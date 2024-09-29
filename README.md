## Criação de Infraestrutura de autorização e integração App<->ApiGateway

Infrastructure as Code. Utiliza Terraform para a criação/manutenção dos recursos na nuvem AWS.

### Como realizar o deployment

O Terraform está integrado ao workflow do Github Actions. 
Ao realizar alterações no código em uma branch dedicada, utilize o fluxo de Pull Request / revisão / aprovação  para ter as mudanças aplicadas




### Comandos úteis

**Criar um usuário teste**

    test-utils/create-test-user.sh  (USER EMAIL)  (CPF)
