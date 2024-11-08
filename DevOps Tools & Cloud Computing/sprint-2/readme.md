

# Projeto de Deploy com Docker e Azure

## Descrição do Projeto
Este projeto consiste em uma aplicação que foi preparada para deployment em uma máquina virtual no Microsoft Azure, utilizando Docker para orquestrar contêineres dos serviços necessários. A arquitetura inclui uma aplicação em Java, um serviço em .NET e um banco de dados Oracle, todos configurados para rodar de forma integrada através de Docker Compose.

## Pré-requisitos

- Conta no [Microsoft Azure](https://azure.microsoft.com/) para criar e gerenciar a máquina virtual.
- [Docker](https://docs.docker.com/get-docker/) instalado e configurado na máquina virtual.
- [Git](https://git-scm.com/downloads) para clonar o repositório.

## 1. Deployment na Nuvem

### 1.1 Criação da Máquina Virtual no Azure

1. No portal do Azure, crie uma nova máquina virtual:
 - **Sistema Operacional**: Ubuntu Server 20.04 LTS.
 - **Tamanho da Máquina**: Standard B1ms (baixo custo).
 - Habilite o monitoramento de integridade, desempenho e dependências de rede.

2. Após a criação, conecte-se à máquina virtual via SSH e instale o Docker utilizando os comandos oficiais para Linux.

### 1.2 Instalação e Configuração do Docker

1. Após instalar o Docker, verifique a instalação com o comando:

   ```
   docker --version` 

2.  Instale o Docker Compose na máquina virtual para permitir o deployment dos contêineres com o arquivo `.yml` deste projeto.


## 2. Docker e Docker Compose

### 2.1 Arquivo Dockerfile

O Dockerfile para este projeto foi configurado para definir as imagens dos serviços em Java e .NET com as configurações e dependências necessárias, além de um banco de dados Oracle.

### 2.2 Arquivo Docker Compose

O arquivo `docker-compose.yml` permite que os serviços sejam executados simultaneamente, com comunicação entre eles. Ele define as variáveis de ambiente necessárias e configura as portas para acesso externo.

## 3. Instruções de Deploy

Para realizar o deploy dos contêineres:

1.  Clone este repositório no diretório padrão da VM:
    
    `git clone <https://github.com/patinaomi/delfos-machine>
    cd <delfos-machine>` 
    
2.  Execute o Docker Compose para construir e iniciar os serviços:
    
    `docker-compose up --build -d` 
    
3.  Verifique se os contêineres estão em execução:
    
    
    `docker ps` 
    

## 4. Testes

Para testar a aplicação, utilize as portas definidas no `docker-compose.yml` para acessar os serviços em Java e .NET.

-   **Aplicação Java**: Porta `8080`
-   **Aplicação .NET**: Porta `5000`
-   **Banco de Dados Oracle**: Porta `1521`

Certifique-se de que cada serviço responde corretamente e que a comunicação entre eles está funcionando conforme esperado.

## 5. Links dos Dockerfiles

Utilize os links abaixo para acessar os Dockerfiles diretamente:
-   [Dockerfile Java](https://github.com/patinaomi/delfos-machine/blob/main/JAVA%20ADVANCED/sprint-2/challenge/Dockerfile)
-   [Dockerfile .NET](https://github.com/patinaomi/delfos-machine/blob/main/Advanced%20Business%20With%20.NET/sprint-2/DelfosMachine/Dockerfile)
-   [Docker Compose](https://github.com/patinaomi/delfos-machine/blob/main/docker-compose.yml)

## Documentação da API
Foi realizada a documentação da API utilizando **Swagger**, o que facilita a visualização e teste de todos os endpoints disponíveis no sistema. Para acessar a documentação completa, basta visitar o link [Swagger](http://localhost:8080/swagger-ui/index.html#/) quando o projeto estiver em execução.

Além disso, o projeto conta com um arquivo de exportação do Postman contendo todas as requisições para teste dos endpoints da API. Esse arquivo pode ser importado diretamente no Postman, facilitando a realização de testes e a validação das funcionalidades disponíveis. Basta acessar o arquivo [por este link](https://github.com/patinaomi/delfos-machine/blob/main/JAVA%20ADVANCED/sprint-2/Challenge%20Odontoprev.postman_collection.json) e importar no Postman para ter acesso a todas as operações configuradas.

#### Cliente

- **GET /clientes**: Lista todos os clientes.
- **POST /clientes/criar**: Cria um novo cliente.
- **GET /clientes/{id}**: Retorna os detalhes de um cliente específico pelo ID.
- **PUT /clientes/{id}**: Atualiza as informações de um cliente.
- **PATCH /clientes/{id}/**: Atualiza parcialmente um dado do cliente.
- **DELETE /clientes/{id}**: Remove um cliente.
