#!/usr/bin/env python3
from operator import attrgetter
import boto3
AWS_REGION = "us-east-1"
EC2_RESOURCE = boto3.resource('ec2', region_name=AWS_REGION)
images = EC2_RESOURCE.images.filter(
     Filters=[
        {
            'Name': 'name',
            'Values': [
                '*EC2-Amazon2*',
            ]
        },
    ],
   Owners=['self']
)
image_details = sorted(list(images), key=attrgetter('creation_date'), reverse=True)
# for i in images:
#     print(i)
print(f'Latest AMI: {image_details[0].id}')

ssm_client = boto3.client('ssm', region_name=AWS_REGION)
ssm_client.put_parameter(Name="tapoc-latest-ami", Overwrite=True,Value=image_details[0].id,Type="String")