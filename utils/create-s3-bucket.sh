#!/bin/bash
echo "Starting the script to create the bucket"
bucket_name="$1"

if [ "$bucket_name" == "" ]
then
  echo "Bucket name is required"
  exit 1
fi

#aws s3api head-bucket --bucket $bucket_name
aws s3 ls | grep -i $bucket_name
if [ $? -eq 0 ]
then
  echo "Bucket $bucket_name exists"
  exit 0
fi

echo "Bucket $bucket_name will be created"
#aws s3 mb s3://$bucket_name
aws s3api create-bucket --bucket $bucket_name
