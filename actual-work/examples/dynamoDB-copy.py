import argparse
import boto3 as boto3
import datetime;

source_account_dynamodb = boto3.client('dynamodb')
destination_account_dynamodb = boto3.client('dynamodb')

ct = datetime.datetime.now()
print("current time:-", ct)

dynamo_paginator = source_account_dynamodb.get_paginator('scan')
dynamo_response = dynamo_paginator.paginate(TableName="DynamoDB-GSI-LSI",Select='ALL_ATTRIBUTES',ReturnConsumedCapacity='NONE',ConsistentRead=True)



for page in dynamo_response:
        for item in page['Items']:
            print(item)
            destination_account_dynamodb.put_item(
                TableName="DynamoDB-GSI-LSI-dest",
                Item=item
            )

ct1 = datetime.datetime.now()
print("current time:-", ct1)
print("Completed")