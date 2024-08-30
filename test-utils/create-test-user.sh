#!/bin/bash
# Utilize depois de criada a infraestrutura do Cognito

if [ $# -ne 2 ]
then
  echo "Usage: $0  (USER EMAIL)  (CPF)"
  exit 1
fi

email=$1
cpf=$2

# Assumindo que só existe 1 pool!
poolId="$(aws cognito-idp list-user-pools --max-results 10 --query 'UserPools[?Name==`customer-logins`].Id | [0]' | tr -d '"')"

if [ "$poolId" == "" ]
then
  echo "User Pool customer-logins nao disponivel"
  exit 1
fi

aws cognito-idp admin-create-user --user-pool-id $poolId --username $email \
    --user-attributes Name=email,Value=$email Name=custom:cpf,Value=$cpf \
    --temporary-password Burgers2024

if [ $? -ne 0 ]
then
  echo "Erro criando usuario"
  exit 1
fi

aws cognito-idp admin-set-user-password --user-pool-id $poolId  \
    --username $email --password Burgers2024 --permanent

if [ $? -ne 0 ]
then
  echo "Erro definindo senha"
  exit 1
fi

aws cognito-idp admin-add-user-to-group --user-pool-id $poolId  \
    --username $email --group-name ClientesCadastrados

if [ $? -ne 0 ]
then
  echo "Erro associando ao grupo"
  exit 1
fi
