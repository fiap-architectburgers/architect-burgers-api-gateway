#!/bin/bash

lbarn=$(aws elbv2 describe-load-balancers --query 'LoadBalancers[?Type==`network`].LoadBalancerArn | [0]')

echo Load Balancer ARN: $lbarn

lisArn=$(aws elbv2 describe-listeners --load-balancer-arn ${lbarn//\"/} --query 'Listeners[?Port==`8090`].ListenerArn | [0]')

echo "Data ready. Now run:"
echo export TF_VAR_load_balancer_listener_arn=$lisArn
