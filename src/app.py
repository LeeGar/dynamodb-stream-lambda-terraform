from __future__ import print_function

def handler(event, context):
    for record in event['Records']:
        hash_key = record['dynamodb']['Keys']['TestTableHashKey']['S']
        print("Received message from DynamoDB Stream!")
        print(f"Dynamo hash key: {hash_key}")
        
