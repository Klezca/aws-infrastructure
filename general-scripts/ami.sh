#!/bin/bash

# List all linux 2 ami in all regions and output in output.txt file
for region in `aws ec2 describe-regions --output text | cut -f4`
do
     echo -e "\nListing amazon linux 2 ami in region:'$region'..." >> output.txt
     aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2' 'Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' --region $region --output text >> output.txt
done