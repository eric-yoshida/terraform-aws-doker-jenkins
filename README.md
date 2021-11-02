# Terraform - Instalação Jenkins em Docker (EC2) - AWS

Este repositório contém arquivos em Terraform para provisionamento de VPC, Subnets, EC2 e instalação de Docker e Jenkins.
Para ser possível realizar a execução deste projeto, serão necessários os seguintes acessos, instalações e chaves:
  * Conta AWS
    * Bucket S3
      * Para armazenamento de arquivo .tfstate
    * EC2 Key-pair
      * Para criação de instâncias
  
  * Local
    * Terraform Client
      * https://www.terraform.io/downloads.html
    * AWS Cli
      * Para permissão de acesso do Terraform a conta AWS  
    * Realizar o download dos diretórios Setup-VPC e Setup-EC2
    

## Executando criação de VPC
### Editar o arquivo Backend.tf (diretório Setup-VPC)
Inserir seu Bucket S3 substiuindo a string "your-bucket", no paramentro Bucket (linha 3).

### Executar os comandos:
terraform init
terraform plan

Caso o terraform concluir o terraform plan com sucesso, seguir com o comando abaixo:
terraform apply

Esta execução criará:
  * VPC chamada "my-vpc";
  * 3 subnets privadas;
  * 3 subnets publicas;
  * Cada subnet publica e privada criadas em AZ's distintas;
  * Região: us-east.

## Executando crição de EC2
### Editar o arquivo Backend.tf (diretório Setup-EC2)
Inserir seu Bucket S3 substiuindo a string "your-bucket", no paramentro Bucket (linha 3).

### Editar o arquivo ec2.tf (diretório Setup-EC2)
Inserir o id da aws key-pair, substituindo a string "your-key-pair", no parametro key_name (linha 45)

### Executar os comandos:
terraform init
terraform plan

Caso o terraform concluir o terraform plan com sucesso, seguir com o comando abaixo:
terraform apply

Esta execução criará:
  * Instancia EC2 para cada subnet pública;
  * Instalação Docker em cada instância;
  * Instalação Jenkins em cada Docker;

## Acessando a aplicação
Para acessar a aplicação, será necessário confirmar os IP's públicos para cada EC2 criada no ambiente AWS.
Utilizar os IP's em qualquer navegador para acessar a aplicação.

## Work in Progress
Projeto em desenvolvimento.
  * Melhoria para acesso por loadbalancer
  * Melhoria para utilização de BD.
