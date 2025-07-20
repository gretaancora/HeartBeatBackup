import json
import boto3
import os
from datetime import datetime, timezone

# Client DynamoDB
dynamodb = boto3.client('dynamodb')
# Tabelle environment
CLINICAL_RECORDS_TABLE = os.environ.get('CLINICAL_RECORDS_TABLE')
DOCTOR_PATIENT_TABLE = os.environ.get('DOCTOR_PATIENT_TABLE')  

# Intestazioni CORS standard
CORS_HEADERS = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type,Authorization",
    "Access-Control-Allow-Methods": "OPTIONS,GET,PUT,POST"
}

def lambda_handler(event, context):
    # Gestione preflight CORS
    if event.get('httpMethod', '') == 'OPTIONS':
        return {
            "statusCode": 200,
            "headers": CORS_HEADERS,
            "body": json.dumps({"message": "CORS preflight OK"})
        }

    try:
        # 1) Parse diretto del body JSON
        body_str = event.get('body') or ''
        payload = json.loads(body_str)

        # 2) Supporto batch: normalizza in lista
        records = [payload] if isinstance(payload, dict) else payload
        if not isinstance(records, list):
            raise ValueError("Payload deve essere un oggetto o un array di oggetti")

        # 3) Validazione minima, controllo associazione e insert su DynamoDB
        for i, rec in enumerate(records, start=1):
            # Controlla campi obbligatori
            for f in ('patient', 'doctor', 'anomalyDescription'):
                if f not in rec:
                    return {
                        "statusCode": 400,
                        "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
                        "body": json.dumps({
                            "error": f"Manca il campo '{f}' nel record #{i}"
                        })
                    }

            patient_id = rec['patient']
            doctor_id = rec['doctor']

            # 3a) Controllo associazione Doctor-Patient
            assoc_response = dynamodb.get_item(
                TableName=DOCTOR_PATIENT_TABLE,
                Key={
                    'doctor': {'S': doctor_id},
                    'patient': {'S': patient_id}
                }
            )
            if 'Item' not in assoc_response:
                return {
                    "statusCode": 400,
                    "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
                    "body": json.dumps({
                        "error": f"Nessuna associazione trovata tra doctor '{doctor_id}' e patient '{patient_id}' nel record #{i}"
                    })
                }

            # 3b) Calcola timestamp al momento della scrittura (UTC ISO 8601)
            now_ts = datetime.now(timezone.utc).isoformat()

            # 3c) Inserimento in DynamoDB
            dynamodb.put_item(
                TableName=CLINICAL_RECORDS_TABLE,
                Item={
                    'patient':            {'S': patient_id},
                    'timestamp':          {'S': now_ts},
                    'doctor':             {'S': doctor_id},
                    'anomalyDescription': {'S': rec['anomalyDescription']}
                }
            )

        # 4) Risposta proxy-style con CORS
        return {
            "statusCode": 200,
            "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
            "body": json.dumps({"message": "Dati inseriti correttamente"})
        }

    except ValueError as ve:
        return {
            "statusCode": 400,
            "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
            "body": json.dumps({"error": str(ve)})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {**CORS_HEADERS, "Content-Type": "application/json"},
            "body": json.dumps({"error": f"Errore interno: {e}"})
        }
