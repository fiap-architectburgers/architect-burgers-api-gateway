


## Comandos úteis

# Criar um usuário teste

    aws cognito-idp admin-create-user --user-pool-id us-east-1_IA2yj2CXl --username gomesrodrigo0481+duduburger@gmail.com \
        --user-attributes Name=email,Value=gomesrodrigo0481+duduburger@gmail.com Name=custom:cpf,Value=12332112340 \
        --temporary-password Burgers2024 

    aws cognito-idp admin-set-user-password --user-pool-id us-east-1_IA2yj2CXl  \
        --username '74c824c8-9061-7018-dea5-61622a7121df' --password Burgers2024 --permanent



