#!/bin/bash

# This shell script is for configuring aws-cli in Gitlab CI

AWS_ACCESS_KEY_ID=$1 #First parameter is your access key id 
AWS_SECRET_ACCESS_KEY=$2 
AWS_DEFAULT_REGION=$3 # the region which you'll be deploying to
AWS_DEFAULT_OUTPUT=$4 # out put format: json|text

credentialsconf=""
credentialsconf="[default]\n"
credentialsconf+=$"aws_access_key_id = $AWS_ACCESS_KEY_ID\n"
credentialsconf+=$"aws_secret_access_key = $AWS_SECRET_ACCESS_KEY\n"

echo -e $credentialsconf > .aws/credentials

config=""
config+=$"[default]\n"
config+=$"region = $AWS_DEFAULT_REGION\n"
config+=$"output = $AWS_DEFAULT_OUTPUT\n"

echo -e $config > .aws/config
