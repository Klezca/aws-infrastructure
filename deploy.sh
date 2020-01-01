#!/bin/bash

# This is a template for deploying cloudformation

# You can test the stack and the different concepts in AWS console to understand the concepts 
# before writing a bash script, python, node or whatever scripting language 
# that can run on the operating system used by Gitlab CI.

# Edit this script to fit with development/ production deployment in Gitlab CI 
###### Not tested in Gitlab CI

# Install zip and unzip utility 
sudo yum install zip
sudo yum install unzip

# Download and install aws2-cli
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# In your machice. Configure aws2 with access id, access key, region, and output value
# Reference: https://docs.aws.amazon.com/cli/latest/topic/config-vars.html
aws2 configure 

# If this is on Gitlab CI,
# then pass GitLab CI environment parameter into the aws-configure.sh script which can be founf in the configuration-file folder
sudo sh aws-configure.sh $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY ap-southeast-2 json

# Download stackformation parameters value stored in s3
aws s3 cp s3://cloudformation-template-treiner/parameter/rootParam-staging.json ~

# CREATE
# You can pass git lab ci parameters to replace the urls
# To make it easier to manage cloudformation parameters in aws-cli, we'll used a json file containing the parameters value stored in s3 
aws2 cloudformation create-stack --stack-name Staging --template-url https://cloudformation-template-treiner.s3.amazonaws.com/template/root.yaml --parameters file://rootParam-staging.json

# alternative: https://github.com/thoughtbot/paperclip/issues/2151
aws2 cloudformation create-stack --stack-name Staging --template-url  https://cloudformation-template-treiner.s3.ap-southeast-2.amazonaws.com/template/root.yaml --parameters file://rootParam-staging.json

# For debugging purposes, disable rollback when Creation failed
aws2 cloudformation create-stack --stack-name Staging --template-url  https://cloudformation-template-treiner.s3.ap-southeast-2.amazonaws.com/template/root.yaml --parameters file://rootParam-staging.json --disable-rollback

# After creating stack, you can list the resources in the stack
aws2 cloudformation list-stack-resources --stack-name 

# List all stack in the account, unless you apply a filter to list only stacks which sastify the filter
aws2 cloudformation list-stacks --stack-status-filter CREATE_COMPLETE

# DEPLOYMENT
# You can deploy the cloudformation stacks manually first with the aws-cli or aws console,
# to create all the resources first,
# then you only need to update the relavant resource (LaunchConfiguration) with each code commit

# A stack update can only be perform if the parameter change or the template configuration has changed

# Reference: https://cloudonaut.io/rolling-update-with-aws-cloudformation/
#            https://aws.amazon.com/premiumsupport/knowledge-center/cloudformation-rolling-updates-launch/

# Alternative deployment 1
# Reference: https://docs.aws.amazon.com/cli/latest/reference/cloudformation/deploy/index.html
# Run deploy command

# Alternative deployment 2
# if [ $stacknameexist ]
# then
#     Run changeset command (Replace the launch configuration used by autoscaling group,
#     all other resources with UpdateReplacePolicy = Retain, will not be Replace) 
# else
#     Create stack

# Changeset
# If you already have an existing stack deployed, and
# If you have rewritten or make changes to the cloudformation template, then use this command to
# get a preview before updating. It will check if cloudformation template is well-formed before updating the deployed stack configuration
# You don't need this if you're not changing your stack template

# DETECT DRIFT
# 1. Check if deployed resources are not consistent with cloudformation template.
# 2. Check to see if someone manually configure the resource in the AWS console
# 3. Deletion will fail if deployed resources are not consistent with cloudformation template.
# 4. Do this command before deleting stack
aws2 cloudformation detect-stack-drift --stack-name Stagingstack

# DELETE 
# Delete stack and all the resources deployed (unless DeletionPolicy: Retain)
aws2 cloudformation delete-stack --stack-name Stagingstack
