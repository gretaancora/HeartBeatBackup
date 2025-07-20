import { 
  CognitoIdentityProviderClient, 
  SignUpCommand, 
  AdminConfirmSignUpCommand, 
  AdminAddUserToGroupCommand 
} from "@aws-sdk/client-cognito-identity-provider";
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";
import crypto from "crypto";

// Environment variables
const USER_POOL_ID      = process.env.USER_POOL_ID;
const APP_CLIENT_ID     = process.env.APP_CLIENT_ID;
const APP_CLIENT_SECRET = process.env.APP_CLIENT_SECRET;
const PATIENT_GROUP     = process.env.PATIENT_GROUP;
const DOCTOR_PATIENT_TABLE    = process.env.DOCTOR_PATIENT_TABLE;

// CORS headers
const CORS_HEADERS = {
  "Access-Control-Allow-Origin":  "*", // o il tuo dominio
  "Access-Control-Allow-Headers": "Content-Type,Authorization,x-local-storage-token",
  "Access-Control-Allow-Methods": "OPTIONS,POST"
};

// Initialize AWS SDK clients
const cognitoClient = new CognitoIdentityProviderClient({});
const ddbClient     = new DynamoDBClient({});
const ddbDocClient  = DynamoDBDocumentClient.from(ddbClient);

function getSecretHash(username) {
  const hmac = crypto.createHmac('sha256', APP_CLIENT_SECRET);
  hmac.update(username + APP_CLIENT_ID);
  return hmac.digest('base64');
}

function parseJwt(token) {
  const parts = token.split('.');
  if (parts.length !== 3) throw new Error('Invalid JWT format');
  const payload = Buffer.from(parts[1], 'base64').toString('utf8');
  return JSON.parse(payload);
}

export const handler = async (event) => {
  console.info('Event:', JSON.stringify(event));

  // --- CORS preflight ---
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: CORS_HEADERS,
      body: ''
    };
  }

  // --- Body parsing ---
  let body;
  try {
    body = JSON.parse(event.body || '{}');
  } catch {
    return {
      statusCode: 400,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: 'Invalid JSON' })
    };
  }
  const { email, password } = body;
  if (!email || !password) {
    return {
      statusCode: 400,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: 'Email and password required' })
    };
  }

  // --- Token extraction (header or fallback) ---
  let token;
  const authHeader = event.headers?.authorization || event.headers?.Authorization;
  if (authHeader?.startsWith('Bearer ')) {
    token = authHeader.slice(7);
  } else {
    token = event.headers?.['x-local-storage-token'];
  }

  // --- Doctor resolution ---
  let doctor = 'UNKNOWN_DOCTOR';
  if (token) {
    try {
      const claims = parseJwt(token);
      doctor = claims.email || claims['email'] || claims['cognito:username'] || doctor;
      console.info('Doctor extracted from token:', doctor);
    } catch (e) {
      console.warn('JWT parse failed for doctor extraction', e);
    }
  } else {
    console.warn('No token provided in headers or x-local-storage-token');
  }

  try {
    // 1) Sign up
    const secretHash = getSecretHash(email);
    await cognitoClient.send(new SignUpCommand({
      ClientId:       APP_CLIENT_ID,
      Username:       email,
      Password:       password,
      SecretHash:     secretHash,
      UserAttributes: [{ Name: 'email', Value: email }],
    }));

    // 2) Confirm sign-up
    await cognitoClient.send(new AdminConfirmSignUpCommand({
      UserPoolId: USER_POOL_ID,
      Username:   email,
    }));

    // 3) Add to group
    await cognitoClient.send(new AdminAddUserToGroupCommand({
      UserPoolId: USER_POOL_ID,
      Username:   email,
      GroupName:  PATIENT_GROUP,
    }));

    // 4) Persist link
    await ddbDocClient.send(new PutCommand({
      TableName: DOCTOR_PATIENT_TABLE,
      Item:      { doctor, patient: email },
    }));

    return {
      statusCode: 200,
      headers: CORS_HEADERS,
      body: JSON.stringify({
        message: `User ${email} registered, confirmed, added to group ${PATIENT_GROUP}, linked to doctor ${doctor}`
      })
    };
  } catch (err) {
    console.error('Flow error', err);
    return {
      statusCode: 500,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: err.message })
    };
  }
};
