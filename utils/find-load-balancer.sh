#!/bin/bash

lbarn=$(aws elbv2 describe-load-balancers --query 'LoadBalancers[?Type==`network`].LoadBalancerArn | [0]' --output text)

if [ "$lbarn" == "" -o "$lbarn" == "null" -o "$lbarn" == "None" ]
then
  echo "Error - Could not get the Network Load Balancer. Is the K8s Service deployed?"  >&2
  exit 1
fi

lisArn=$(aws elbv2 describe-listeners --load-balancer-arn ${lbarn} --query 'Listeners[?Port==`8090`].ListenerArn | [0]' --output text)

if [ "$lisArn" == "" -o "$lisArn" == "null" -o "$lisArn" == "None" ]
then
  echo "Error - Could not get the Network Load Balancer Listener (8090). Is the K8s Service deployed?"  >&2
  exit 1
fi

echo "LISTENER_ARN=$lisArn"