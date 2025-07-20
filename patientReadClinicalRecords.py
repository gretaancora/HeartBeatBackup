import json
import boto3
import os

# Inizializza il client DynamoDB
dynamodb = boto3.client('dynamodb')
CLINICAL_RECORDS_TABLE = os.environ.get('CLINICAL_RECORDS_TABLE')

# Header CORS
CORS_HEADERS = {
    'Access-Control-Allow-Origin': '*',  # o il tuo dominio specifico
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'OPTIONS,GET,POST'
}

def lambda_handler(event, context):
    """
    Lambda function per leggere i record clinici dalla tabella DynamoDB.
    Riceve in input solo il patient_id come parametro e restituisce i record corrispondenti.
    Gestisce CORS.
    """

    # 1) Preflight CORS
    if event.get('httpMethod') == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': CORS_HEADERS,
            'body': ''
        }

    try:
        # 2) Parametri da query string o body
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

        # 3) Verifica parametro patient_id
        if not patient_id:
            return {
                'statusCode': 400,
                'headers': CORS_HEADERS,
                'body': json.dumps({'error': 'Parametro patient obbligatorio'})
            }

        # 4) Query dei record clinici per patient_id
        query_args = {
            'TableName': CLINICAL_RECORDS_TABLE,
            'KeyConditionExpression': 'patient = :pid',
            'ExpressionAttributeValues': {':pid': {'S': patient_id}},
            'Limit': limit
        }
        if exclusive_start_key:
            query_args['ExclusiveStartKey'] = exclusive_start_key

        response = dynamodb.query(**query_args)
        items = response.get('Items', [])
        last_evaluated_key = response.get('LastEvaluatedKey')

        return {
            'statusCode': 200,
            'headers': {**CORS_HEADERS, 'Content-Type': 'application/json'},
            'body': json.dumps({
                'items': items,
                'lastKey': last_evaluated_key
            })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'headers': CORS_HEADERS,
            'body': json.dumps({'error': str(e)})
        }
