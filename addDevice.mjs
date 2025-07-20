import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";

// Environment variable per la tabella DynamoDB
const DDB_TABLE_NAME = process.env.DDB_TABLE_NAME;
if (!DDB_TABLE_NAME) {
  throw new Error("Missing required env var: DDB_TABLE_NAME");
}

// Inizializza client DynamoDB
const ddbClient = new DynamoDBClient({});
const ddbDocClient = DynamoDBDocumentClient.from(ddbClient);

// Header CORS condivisi
const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "Content-Type,Authorization",
  "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
};

/**
 * Parse un JWT token senza dipendenze esterne
 */
function parseJwt(token) {
  const parts = token.split('.');
  if (parts.length !== 3) throw new Error('Invalid JWT format');
  const payload = parts[1];
  const decoded = Buffer.from(payload, 'base64').toString('utf8');
  return JSON.parse(decoded);
}

/**
 * Normalizza gli input: accetta oggetto singolo o array
 */
function normalizeEntries(body) {
  if (Array.isArray(body)) return body;
  if (body && typeof body === 'object') return [body];
  throw new Error('Request body must be an object or array of objects');
}

export const handler = async (event) => {
  console.info('Received event', JSON.stringify(event));

  // Rispondi subito al preflight CORS
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 204,
      headers: CORS_HEADERS,
      body: ''
    };
  }

  // Controllo Authorization header
  const authHeader = event.headers?.authorization || event.headers?.Authorization;
  if (!authHeader?.startsWith('Bearer ')) {
    return {
      statusCode: 401,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: 'Unauthorized' })
    };
  }

  // Estrai patientId dal JWT
  let patientId;
  try {
    const token = authHeader.slice(7);
    const payload = parseJwt(token);
    patientId = payload['cognito:username'] || payload.username || payload.email;
    if (!patientId) throw new Error('Username claim missing');
  } catch (err) {
    console.error('Token parse error', err);
    return {
      statusCode: 400,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: 'Invalid token' })
    };
  }

  // Parsing e normalizzazione del body
  let entries;
  try {
    const parsed = JSON.parse(event.body || '{}');
    entries = normalizeEntries(parsed);
  } catch (err) {
    console.error('Body parse error', err);
    return {
      statusCode: 400,
      headers: CORS_HEADERS,
      body: JSON.stringify({ message: 'Invalid JSON body or format' })
    };
  }

  // Processa ogni entry
  const results = [];
  for (const entry of entries) {
    const { deviceId, age, sex } = entry;
    if (!deviceId || age === undefined || !sex) {
      results.push({ entry, status: 'failed', reason: 'deviceId, age, and sex required' });
      continue;
    }

    const item = { patientId, deviceId, age, sex };
    try {
      await ddbDocClient.send(
        new PutCommand({ TableName: DDB_TABLE_NAME, Item: item })
      );
      results.push({ entry: item, status: 'success' });
    } catch (err) {
      console.error('DynamoDB error for', entry, err);
      results.push({ entry, status: 'failed', reason: err.message });
    }
  }

  // Restituisci il risultato includendo gli header CORS
  return {
    statusCode: 200,
    headers: CORS_HEADERS,
    body: JSON.stringify({ message: 'Processed entries', results })
  };
};
