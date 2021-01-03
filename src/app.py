from __future__ import print_function

def handler(event, context):
    count = 0
    for record in event['Records']:
        hash_key = record['dynamodb']['Keys']['TestTableHashKey']['S']
        print(f"Dynamo hash key: {hash_key}")
