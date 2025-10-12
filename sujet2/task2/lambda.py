import json
from datetime import datetime


def lambda_handler_hello(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('Hello World!')
    }

def lambda_handler_date(event, context):
    current_datetime = datetime.now()
    current_date_time = current_datetime.strftime("%d/%m/%Y, %H:%M:%S")
    return {
        'statusCode': 200,
        'body': json.dumps(current_date_time)
    }

def lambda_handler_message(event, context):
    parameter = event.get("queryStringParameters")
    if parameter != None:
        parameter = parameter.get("text")
    if parameter != None:
        return {
        'statusCode': 200,
        'body': json.dumps(parameter)
         }
    else:
        return {
        'statusCode': 200,
        'body': json.dumps("Please INPUT your message")
         }  
