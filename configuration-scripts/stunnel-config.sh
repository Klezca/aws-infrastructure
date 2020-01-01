#!/bin/bash

DATABASE_URL=$1 #First parameter is a redis node or cluster url
LOCALPORT=$2 #Second parameter is the Redis port your app is using to connect to the AWS Elasticache port


# Now we create our configuration file as a variable
stunnelconf=""
stunnelconf+=$"fips = no\n" 
stunnelconf+=$"setuid = root\n" 
stunnelconf+=$"setgid = root\n" 
stunnelconf+=$"pid = /var/run/stunnel.pid\n" 
stunnelconf+=$"debug = 7\n" 
stunnelconf+=$"delay = yes\n" 
stunnelconf+=$"options = NO_SSLv2\n" 
stunnelconf+=$"options = NO_SSLv3\n" 

# Configuration for Primary Node. You can write a loop to automatically write the rest of the nodes configuration
# If your app wants to Read from the Read Replica, then you can change connect=$DATABASE_URL to your Read Replica URL
# This configuration will "accept" connections from MANY ports (6379,6380, depnds on your setup) and map it to port 6379 
stunnelconf+=$"[master]\n"
stunnelconf+=$"client=yes\n"
stunnelconf+=$"accept=127.0.0.1:$LOCALPORT\n"
stunnelconf+=$"connect=$DATABASE_URL:6379\n"

# Example of Read Replica configuration
    # stunnelconf+=$"[ReadReplica1]\n"
    # stunnelconf+=$"client=yes\n"
    # stunnelconf+=$"accept=127.0.0.1:6380\n"
    # stunnelconf+=$"connect=$ReadReplicaURL:6379\n"

echo -e $stunnelconf > redis-cli.conf

# # Grab the pid
# stunnelpid=$!
# # Sleep a moment to let the connection establish
# sleep 1 
# # Now call redis-cli for the user to interact with
# redis-cli -p $LOCALPORT 
# # Once they leave that, kill the stunnel
# kill $stunnelpid
