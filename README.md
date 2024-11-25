## Criação de Integração App<->ApiGateway e infraestrutura de autorização

Infrastructure as Code. Utiliza Terraform para a criação/manutenção dos recursos na nuvem AWS.

- Setup do API Gateway: rotas e integração com serviços do k8s
- Autorização customizada com Lambda
 
### Como realizar o deployment

O Terraform está integrado ao workflow do Github Actions. 
Ao realizar alterações no código em uma branch dedicada, utilize o fluxo de Pull Request / revisão / aprovação  para ter as mudanças aplicadas.




### Comandos úteis

**Criar um usuário teste**

    test-utils/create-test-user.sh  (USER EMAIL)  (CPF)  (NOME)

**Execução local**

O script `utils/run-local.sh` reproduz os passos do Git Workflow; ambiente local deve ter acesso ao ambiente AWS com a devida configuração das credenciais.
