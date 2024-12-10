## !/bin/bash -e

PROXY_ID=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'`
DNS_NAME=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[].PublicDnsName'`

if [ ! -z "${DNS_NAME}" ]; then
  aws ec2 stop-instances --instance-ids "${PROXY_ID}" >> /dev/null
  sleep 120
fi

aws ec2 start-instances --instance-ids "${PROXY_ID}" >> /dev/null

sleep 120
SEKITOBA_PROXY=`aws ec2 describe-instances | jq -r '.Reservations[].Instances[].PublicDnsName'`
echo $SEKITOBA_PROXY
