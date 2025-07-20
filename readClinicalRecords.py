import json
import boto3
import os
import base64

# Inizializza il client DynamoDB
dynamodb = boto3.client('dynamodb')
CLINICAL_RECORDS_TABLE = os.environ.get('CLINICAL_RECORDS_TABLE')
DOCTOR_PATIENT_TABLE = os.environ.get('DOCTOR_PATIENT_TABLE')

# Header CORS
CORS_HEADERS = {
    'Access-Control-Allow-Origin': '*',  # o il tuo dominio specifico
    'Access-Control-Allow-Headers': 'Content-Type,Authorization,x-local-storage-token',
    'Access-Control-Allow-Methods': 'OPTIONS,GET,POST'
}

def parse_jwt_payload(token):
    """
    Estrae e decodifica il payload di un JWT (base64url).
    """
    try:
        parts = token.split('.')
        payload_b64 = parts[1] + '=' * (-len(parts[1]) % 4)
        decoded = base64.urlsafe_b64decode(payload_b64)
        return json.loads(decoded)
    except Exception:
        return {}

def lambda_handler(event, context):
    """
    Lambda function per leggere i record dalla tabella DynamoDB.
    Verifica prima nel table DoctorPatient che il doctor sul token
    abbia permessi sul patient richiesto. Gestisce CORS.
    """

    # 1) Preflight CORS
    if event.get('httpMethod') == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': CORS_HEADERS,
            'body': ''
        }

    # 2) Estrai token da header Authorization o x-local-storage-token
    headers = event.get('headers') or {}
    auth = headers.get('Authorization') or headers.get('authorization')
    if auth and auth.startswith('Bearer '):
        token = auth[len('Bearer '):]
    else:
        token = headers.get('x-local-storage-token')

    # 3) Decodifica il JWT per ottenere il doctor (username)
    claims = parse_jwt_payload(token or '')
    doctor = claims.get('email') or claims.get('cognito:username') or claims.get('sub')
    if not doctor:
        return {
            'statusCode': 401,
            'headers': CORS_HEADERS,
            'body': json.dumps({ 'error': 'Token non valido o mancante claim doctor' })
        }

    try:
        # 4) Parametri da query string o body
        params = event.get('queryStringParameters') or {}
        body_params = {}
        if event.get('body'):
            try:
                body_params = json.loads(event['body']) or {}
            except json.JSONDecodeError:
                body_params = {}

        patient_id = params.get('patient') or body_params.get('patient')
        limit = int(params.get('limit') or body_params.get('limit', '100'))
        last_key = params.get('lastKey') or body_params.get('lastKey')
        exclusive_start_key = json.loads(last_key) if last_key else None

        # 5) Controllo esistenza relazione Doctor–Patient
        if not patient_id:
            return {
                'statusCode': 400,
                'headers': CORS_HEADERS,
                'body': json.dumps({ 'error': 'Parametro patient obbligatorio' })
            }

        dp_query = {
            'TableName': DOCTOR_PATIENT_TABLE,
            'KeyConditionExpression': 'doctor = :d and patient = :p',
            'ExpressionAttributeValues': {
                ':d': {'S': doctor},
                ':p': {'S': patient_id}
            },
            'Limit': 1
        }
        dp_resp = dynamodb.query(**dp_query)
        if dp_resp.get('Count', 0) == 0:
            return {
                'statusCode': 403,
                'headers': CORS_HEADERS,
                'body': json.dumps({ 'error': 'Accesso negato: nessuna relazione Doctor–Patient trovata' })
            }

        # 6) Se relazione OK, procedi con query/scan dei record clinici
        if patient_id:
            query_args = {
                'TableName': CLINICAL_RECORDS_TABLE,
                'KeyConditionExpression': 'patient = :pid',
                'ExpressionAttributeValues': {':pid': {'S': patient_id}},
                'Limit': limit
            }
            if exclusive_start_key:
                query_args['ExclusiveStartKey'] = exclusive_start_key
            response = dynamodb.query(**query_args)
        else:
            scan_args = {
                'TableName': CLINICAL_RECORDS_TABLE,
                'Limit': limit
            }
            if exclusive_start_key:
                scan_args['ExclusiveStartKey'] = exclusive_start_key
            response = dynamodb.scan(**scan_args)

        items = response.get('Items', [])
        last_evaluated_key = response.get('LastEvaluatedKey')

        return {
            "statusCode": 200,
            "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
            "body": json.dumps({
                "items": items,
                "lastKey": last_evaluated_key
            })
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": CORS_HEADERS,
            "body": json.dumps({ "error": str(e) })
        }
