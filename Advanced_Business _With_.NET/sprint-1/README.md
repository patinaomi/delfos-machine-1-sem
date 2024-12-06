# Projeto Backend Challenge Odontoprev

## Dados dos alunos

1. Claudio Silva Bispo
```bash
    RM 553472
```

2. Patricia Naomi Yamagishi
```bash
    RM 552981
```

## Visão Geral

Este projeto é uma API para gerenciamento de  clientes, clínicas, consultas, feedback e outros recursos relacionados a um sistema odontológico. A API é construída usando ASP.NET Core e MongoDB para armazenamento de dados. Na segunda fase, iremos usar Oracle, pois nosso acesso está bloqueado.

## Problema que o projeto pretende resolver:

1. Ineficiência no gerenciamento de consultas e tratamentos preventivos: muitas clínicas têm dificuldades em organizar e automatizar os agendamentos. Além de perder a oportunidade de atender 100% da carteira de clientes da seguradora. Quando os clientes entram em contato, já é para utilizar o seguro/convênio em momentos de emergências, gerando alto custo/gasto. 

2. Falta de centralização dos dados do paciente: o projeto centraliza todas as informações relevantes sobre a saúde bucal do paciente, incluindo histórico familiar, condições físicas, custo das consultas, notas atribuidas as clinicas, especilistas e clientes. 

3. Dificuldade na comunicação entre a clínica, paciente e seguradora: a plataforma permite notificações automatizadas e mantém um fluxo de comunicação eficiente entre todas as partes envolvidas. 

## Nosso objetivo

Desenvolver uma aplicação móvel, gerenciada em Java, e uma aplicação web, gerenciada em ASP.NET / C#, com o objetivo de sugerir consultas para novos e antigos clientes utilizando inteligência artificial (IA). As sugestões de consultas serão baseadas na localidade preferida do cliente, nas avaliações de feedback das clínicas/especialistas e nos custos mais baixos. Com essa combinação, os clientes poderão realizar suas consultas de rotina de forma contínua, promovendo um ciclo de alta qualidade. Ao mesmo tempo, as clínicas e especialistas manterão um fluxo constante de clientes em suas carteiras. Para que possamos atender um dos pilares que é ter a informação (feedback e informações complementares dos clientes) vamos criar um programa de relacionamento, que visa engajar os clientes e especialistas a criarem conteúdos e informações para que possamos treinar o modelo, entregando valor e ao mesmo tempo, bonificando eles.

# Link com vídeo do prótotipo da nossa aplicação

```bash
    https://youtu.be/4rk6KTjp8mM?si=o-7w2aOF_NlqJ5b-
``` 

1. Será interessante para você entender melhor nossa aplicação, iniciando pelo Mobile.
2. Logo iremos criar o prótotipo da nossa aplicação na web. Será enviada na segunda sprint.

## Tecnologias Utilizadas
- ASP.NET Core
- MongoDB, não vamos usar o Oracle ainda, pois não é necessário.
- C#
- React para aplicação front-end que será onde os dados serão inseridos pelo cliente. Esta funcionalidade estará pronta na segunda sprint.

## Estrutura do Diretório

Nosso projeto será gerenciada com base na Clean Architecture, contendo interfaces dos repósitorios, mantendo a regra do clean code.

src/
├── Domain/                     -> Lógica de negócio e entidades
│   └── Entities/               -> Classes de domínio (models atuais)
│   └── Repositories/           -> Interfaces de repositórios
├── Application/                -> Casos de uso e lógica de aplicação
│   └── Services/               -> Casos de uso (services atuais)
│   └── DTOs/                   -> Objetos de transferência de dados
├── Infrastructure/             -> Implementação de repositórios 
├── Web/                        -> API e interface de usuário(Logo teremos o front)
│   └── Controllers/            -> Controladores da API (controllers atuais)
└── Tests/                      -> Testes unitários e de integração. Está etapa será inserida na segunda sprint.

## Configuração e Execução

### Pré-requisitos

- .NET SDK
- MongoDB: link de acesso ao banco: 

```bash
    mongodb+srv://csspclaudio:clnzEcsY8xmMVXMr@cluster0.kfgkjua.mongodb.net/
``` 

Demais configurações se for necessária:

## Tabelas que serão criadas no banco

```bash
    "ConfiguraracaoMongoDb": {
        "ConnectionString": "mongodb+srv://csspclaudio:clnzEcsY8xmMVXMr@cluster0.kfgkjua.mongodb.net/",
        "DatabaseName": "ProjetoChallenge",
        "CadastroCollectionName": "Cadastros",
        "ClienteCollectionName": "Clientes",
        "AgendaCollectionName": "Agendas",
        "ClinicaCollectionName": "Clinicas",
        "ConsultaCollectionName": "Consultas",
        "DentistaCollectionName": "Dentistas",
        "EstadoCivilCollectionName": "EstadosCivis",
        "FeedbackCollectionName": "Feedbacks",
        "FormularioDetalhadoCollectionName": "FormulariosDetalhados",
        "NotificacoesCollectionName": "Notificacoes",
        "TipoNotificacaoCollectionName": "TiposNotificacao",
        "SinistroCollectionName": "Sinistros"
    },
``` 

### Configuração

1. Clone o repositório:
```bash
    https://github.com/patinaomi/delfos-machine.git
``` 
   
## Execução

1. Restaure as dependências:
```bash
    dotnet restore
```
2. Compile e execute a aplicação:
```bash
    dotnet run
```
3. Acesse o Swagger UI para testar a API:
```bash
http://localhost:3001/swagger
```

## Escopo

O projeto inclui o desenvolvimento de uma plataforma com as seguintes funcionalidades principais:

**Cadastro e gerenciamento de pacientes:** com histórico odontológico, informações pessoais, e detalhes de saúde bucal.

**Agendamento de consultas:** com integração de agenda, preferências de horário e clínicas.

**Notificações automatizadas:** para lembretes de consulta, sinistros, e interações com a clínica.

**Gerenciamento de dentistas e clínicas:** permite o cadastro de dentistas e avaliação das clínicas com base em preço, avaliação e localização.

**Gestão de sinistros:** integração com seguradoras para acompanhamento de sinistros odontológicos, avaliação de processos, e análise de cobertura.

**Autenticação e segurança:** com funcionalidades de login seguro e armazenamento de logs.

## Requisitos Funcionais e Não Funcionais

### Requisitos Funcionais:

**Cadastro de Pacientes:** A aplicação deve permitir o cadastro de clientes com dados detalhados (condição física, histórico familiar, saúde bucal).

**Agendamento de Consultas:** O sistema deve sugerir horários de consultas com base na disponibilidade e preferência do cliente.
Notificações: Envio de notificações automáticas sobre consultas, sinistros e status de tratamento.

**Gerenciamento de Clínicas e Dentistas:** A aplicação deve armazenar e permitir a avaliação de clínicas e dentistas.

**Processamento de Sinistros:** A funcionalidade de sinistros deve permitir o envio e acompanhamento do processo por parte do paciente e seguradora.

**Autenticação de Usuários:** O sistema deve garantir segurança através de login e autenticação de usuários.

### Requisitos Não Funcionais:

**Desempenho:** O sistema deve ser capaz de gerenciar múltiplos agendamentos e dados de pacientes simultaneamente, sem perder performance.
Segurança: Criptografia de dados sensíveis, como informações de login e histórico médico.

**Escalabilidade:** A arquitetura deve permitir a adição de novas funcionalidades, como integração com mais APIs ou novos tipos de notificações.

**Disponibilidade:** O sistema deve estar disponível 99% do tempo para garantir que consultas e notificações sejam acessadas sem interrupções.

**Manutenibilidade:** O uso de uma arquitetura desacoplada deve facilitar a manutenção e atualização do código.

## Descrição de cada classe no detalhe, com atributos, métodos e regra de negócio

# Classe Cadastro

**Responsabilidades da Classe Cadastro:**

Representa o cadastro de um usuário, coletando informações básicas através de um formulário. A classe é responsável por gerenciar os dados de entrada do usuário, como nome, e-mail e telefone. Seu principal objetivo é facilitar o processo de registro de novos usuários no sistema, permitindo a criação de contas de forma eficiente e organizada.

**Atributos:**

idCliente: Identificador único do cadastro em relação ao cliente.
nome: Nome completo do cliente.
Sobrenome: Último sobrenome do cliente.
email: Endereço de email do cliente.
telefone: Número de telefone do cliente.
DataNasc: Data de nascimento do cliente.
endereco: Endereço residencial do cliente.
Senha: Senha de acesso ao site.

Próximos passos:

Criar idCadastro
dataCadastro: Data em que o cadastro foi realizado.

**Método:**

***Cadastrar***
Objetivo: Registrar um novo cliente no sistema com as informações fornecidas.

**Regras de Negócio:**

1. O cadastro não pode ser excluído, apenas criado.
2. Não terá outras classes pois aqui não será realizado a gestão do cliente
3. Terá uma funcionalidade que ao criar o cadastro, será criado o Cliente e na classe Cliente será realizado a gestão.
4. O CPF deve ser único e válido para cada cliente.
5. E-mails devem ser únicos na base

## Classe Cliente

**Responsabilidades da Classe Cliente:**

A classe Cliente representa os dados de um cliente já registrado na plataforma. Seu propósito principal é fornecer métodos para atualização e exclusão dos dados do cliente, além de interagir com o sistema por meio de autenticação.

Essa classe não será responsável por criar clientes, pois o processo de criação será gerenciado pela classe Cadastro. Mesmo que um cliente seja excluído do sistema, o Cadastro correspondente não será apagado, mantendo a integridade dos dados iniciais.

**Atributos:**

A classe Cliente terá os seguintes atributos para armazenar as informações do cliente:

Id: Id de identificação que o banco va gerar automaticamente
idCliente: Identificador único do cliente.
nome: Nome do cliente.
Sobrenome: Último nome do cliente.
email: Endereço de e-mail do cliente.
telefone: Número de telefone de contato.
endereco: Endereço completo do cliente.
dataNascimento: Data de nascimento do cliente.
Senha: Senha de acesso a aplicação.

**Métodos:**

***Atualizar dados do cliente***

Objetivo: Atualizar as informações do cliente, como nome, email, telefone, endereço, e preferências.

***Deletar cliente***

Objetivo: Marcar o cliente como deletado, desativando seu acesso ao sistema.

***Autenticar cliente***

Objetivo: Verificar se o cliente pode acessar a plataforma, validando email e senha.

**Regras de Negócio:**

1. Não é possível criar um novo cliente diretamente nesta classe. O processo de criação é gerenciado pela classe Cadastro.

2. Um cliente pode ser "apagado", mas o seu cadastro no sistema permanecerá inalterado, garantindo o histórico de informações.

3. Autenticação segura é necessária para realizar qualquer operação de atualização ou exclusão, garantindo que apenas o cliente ou um administrador autorizado possa modificar seus dados.

# Classe Agenda

**Responsabilidades da Classe Agenda:**

A classe Agenda gerencia o agendamento de consultas e compromissos do cliente com os dentistas nas clínicas. Ela permite criar, atualizar, cancelar e listar agendamentos de forma eficiente, garantindo que as preferências de horários e disponibilidade das clínicas sejam respeitadas.

**Atributos:**

id: Id gerado pela gestão do banco.
idAgenda: Identificador único do agendamento.
idCliente: Identificador do cliente associado ao agendamento.
idConsulta: Identificador com dados da consulta que atenderá o cliente.
dataConsulta: Data e hora do agendamento.
status: Status do agendamento (ativo, cancelado, concluído).
observacoes: Observações adicionais sobre o agendamento.

**Métodos:**

***Criar agendamento***

Objetivo: Criar um novo agendamento para o cliente com base nas preferências de horário e disponibilidade do dentista e clínica.

***Atualizar agendamento***

Objetivo: Atualizar as informações de um agendamento existente, como data, horário ou clínica.

***Cancelar agendamento***

Objetivo: Cancelar um agendamento, alterando o status para cancelado.

***Listar agendamentos***

Objetivo: Retornar todos os agendamentos do cliente, filtrando por status (concluídos, futuros, cancelados).

***Verificar disponibilidade***

Objetivo: Checar se o dentista e a clínica estão disponíveis para o horário solicitado pelo cliente.

**Regras de Negócio:**

Um cliente só pode cancelar ou alterar um agendamento antes da data marcada.
Agendamentos concluídos não podem ser modificados.
Apenas agendamentos com status ativo serão considerados para futuras consultas e análises.

# Classe Clinica

**Responsabilidades da Classe Clinica:**

A classe Clinica gerencia as informações das clínicas odontológicas, permitindo a atualização, exclusão e consulta de seus dados. A criação de novas clínicas também é feita por esta classe, uma vez que elas podem ser cadastradas diretamente no sistema.

**Atributos:**

idClinica: Identificador único da clínica.
nome: Nome da clínica.
endereco: Endereço da clínica.
telefone: Telefone de contato da clínica.
avaliacao: Avaliação da clínica (1 a 5).
precoMedio: Preço médio dos procedimentos.
email: E-mail de contato da clínica.

**Métodos:**

***CadastrarClinica***

Objetivo: Cadastrar uma nova clínica no sistema.

***AtualizarClinica***

Objetivo: Atualizar informações da clínica, como endereço, telefone ou preço médio.

***DeletarClinica***

Objetivo: Excluir uma clínica do sistema.

***ConsultarClinica***

Objetivo: Obter informações detalhadas sobre uma clínica específica.

***ListarClinicas***

Objetivo: Listar todas as clínicas cadastradas no sistema.

**Regras de Negócio:**

1. Cada clínica deve ter um idClinica único.
2. A avaliação deve ser um valor numérico entre 1 e 5.
3. A exclusão de uma clínica pode ser feita apenas se não houver consultas futuras agendadas.

# Classe Consulta

**Responsabilidades da Classe Consulta:**

A classe Consulta gerencia as informações relacionadas às consultas odontológicas agendadas. Ela permite o registro, atualização e cancelamento de consultas, bem como a consulta de detalhes específicos de uma consulta.

**Atributos:**

idConsulta: Identificador único da consulta.
dataHora: Data e hora agendadas para a consulta.
clienteId: Identificador do cliente que agendou a consulta.
clinicaId: Identificador da clínica onde a consulta será realizada.
status: Status da consulta (agendada, cancelada, concluída).
IdFormaPagamento
IdTipoConsulta
tipo_servico
observacoes
sintomas
tratamento_recomendado
custo
data_retorno

Próximos passos: Valiar se tem necessidade desse dado

dentistaId: Identificador do dentista responsável pela consulta.

**Métodos:**

***AgendarConsulta***

Objetivo: Registrar uma nova consulta no sistema.

***AtualizarConsulta***

Objetivo: Atualizar detalhes de uma consulta já agendada, como data, hora ou status.

***CancelarConsulta***

Objetivo: Cancelar uma consulta agendada.

***ConsultarDetalhes***

Objetivo: Obter informações detalhadas sobre uma consulta específica.

***ListarConsultasPorCliente***

Objetivo: Listar todas as consultas de um cliente específico.

**Regras de Negócio:**

1. Cada consulta deve ter um idConsulta único.
2. Não é permitido agendar consultas em horários que o cliente não deixou como preferência.
3. Consultas podem ser canceladas até um determinado tempo antes do horário agendado.
4. Toda consulta precisa ter data e hora, sendo definida por base nos melhores feedbacks e custo baixo.

# Classe Dentista

**Responsabilidades da Classe Dentista:**

A classe Dentista representa os profissionais odontológicos cadastrados no sistema. Ela gerencia as informações dos dentistas, permitindo a atualização de seus dados e a associação com consultas.

**Atributos:**

idDentista: Identificador único do dentista.
nome: Nome do dentista.
Sobrenome: Último sobrenome do dentista
especialidade: Especialidade do dentista (ex: ortodontia, endodontia).
telefone: Número de contato do dentista.
email: Endereço de e-mail do dentista.
clinicaId: Identificador da clínica onde o dentista trabalha.
Avaliação: Nota atribuida ao dentista. Será ligado com o formulário de feedback.

Próximos passos:
Analisar se precisamos do e-mail do dentista.
crm: Registro no Conselho Regional de Odontologia (CRM).

**Métodos:**

***CadastrarDentista***

Objetivo: Registrar um novo dentista no sistema.

***AtualizarDentista***

Objetivo: Atualizar os dados de um dentista já cadastrado.

***ExcluirDentista***

Objetivo: Remover um dentista do sistema.

***ConsultarDentista***

Objetivo: Obter informações detalhadas sobre um dentista específico.

***ListarDentistas***

Objetivo: Listar todos os dentistas cadastrados no sistema.

**Regras de Negócio:**

1. Cada dentista deve ter um idDentista único.
2. O cadastro de um dentista deve incluir um crm válido.
3. Dentistas podem ser associados a uma ou mais clínicas.

# Classe Estado Civil

**Responsabilidades da Classe EstadoCivil:**
A classe EstadoCivil representa os diferentes estados civis que um cliente pode ter. Ela é utilizada para armazenar informações relacionadas ao estado civil e suas opções disponíveis.

**Atributos:**

idEstadoCivil: Identificador único do estado civil.
descricao: Descrição do estado civil (ex: solteiro, casado, divorciado).

**Métodos:**
CadastrarEstadoCivil

Objetivo: Registrar um novo estado civil no sistema.

***AtualizarEstadoCivil**

Objetivo: Atualizar os dados de um estado civil já cadastrado.

***ExcluirEstadoCivil**

Objetivo: Remover um estado civil do sistema.

***ConsultarEstadoCivil**

Objetivo: Obter informações detalhadas sobre um estado civil específico.

***ListarEstadosCivis***

Objetivo: Listar todos os estados civis cadastrados no sistema.

**Regras de Negócio:**
1. Cada estado civil deve ter um idEstadoCivil único.
2. O estado civil deve ter uma descrição válida e não pode ser nulo.

# Classe Feedback

**Responsabilidades da Classe Feedback:**
A classe Feedback é responsável por armazenar e gerenciar as opiniões e sugestões dos clientes sobre os serviços prestados. Ela coleta informações sobre a satisfação do cliente e permite que a organização melhore seus serviços com base nesse retorno.

**Atributos:**

idFeedback: Identificador único do feedback.
idCliente: Identificador do cliente que fornece o feedback.
idDentista: Identificador do dentista que recebeu o feedback.
idClinica: Identificador da clinica que recebeu o feedback.
Comentário: Conteúdo do feedback fornecido pelo cliente.
avaliacao: Avaliação dada pelo cliente (por exemplo, em uma escala de 1 a 5).
data: Data em que o feedback foi enviado.

**Métodos:**

***CadastrarFeedback***

Objetivo: Registrar um novo feedback no sistema.

***AtualizarFeedback***

Objetivo: Atualizar as informações de um feedback existente.

***ExcluirFeedback***

Objetivo: Remover um feedback do sistema.

***ConsultarFeedback***

Objetivo: Obter detalhes de um feedback específico.

***ListarFeedbacks***

Objetivo: Listar todos os feedbacks recebidos no sistema.

**Regras de Negócio:**

1. Cada feedback deve ter um idFeedback único.
2. O idCliente deve referenciar um cliente existente.
3. avaliação deve estar dentro de um intervalo predefinido (por exemplo, 1 a 5).

# Classe Tipo de Notificação

**Responsabilidades da Classe Tipo de Notificação:**
A classe Tipo de Notificação define os diferentes tipos de notificações que podem ser enviadas aos clientes, como lembretes de consultas, avisos de promoções, ou atualizações de serviços. Ela ajuda a categorizar as mensagens e a gerenciar o envio de notificações.

**Atributos:**

idTipoNotificacao: Identificador único do tipo de notificação.
idCliente: Identificador único do cliente quem recebeu a notificação.
Mensagem: Descrição do tipo de notificação (por exemplo, "Lembrete de Consulta", "Promoção", etc.).
Data do envio.

**Métodos:**

***CadastrarTipoNotificacao***

Objetivo: Registrar um novo tipo de notificação no sistema.

***AtualizarTipoNotificacao***

Objetivo: Atualizar as informações de um tipo de notificação existente.

***ExcluirTipoNotificacao***

Objetivo: Remover um tipo de notificação do sistema.

***ConsultarTipoNotificacao***

Objetivo: Obter detalhes de um tipo de notificação específica.

***ListarTiposNotificacao***

Objetivo: Listar todos os tipos de notificação disponíveis no sistema.

**Regras de Negócio:**

1. Cada tipo de notificação deve ter um idTipoNotificacao único.
2. A descrição deve ser clara e representativa do tipo de notificação.

# Classe Autenticação

**Responsabilidades da Classe Autenticação:

A classe Autenticação gerencia o processo de login e logout dos usuários, garantindo que apenas usuários autorizados tenham acesso ao sistema. Ela valida credenciais e gera tokens de sessão para acesso seguro.

**Atributos:**

usuario: Nome de usuário ou e-mail do usuário.
senha: Senha do usuário, que será validada durante o login.
token: Token gerado após a autenticação bem-sucedida.

**Métodos:**

***Login***

Objetivo: Validar as credenciais do usuário e permitir o acesso ao sistema, gerando um token de sessão.

***Logout***

Objetivo: Encerrar a sessão do usuário, invalidando o token de autenticação.

***ValidarToken***

Objetivo: Verificar se um token de autenticação fornecido é válido e se o usuário está autorizado a acessar recursos.

***RecuperarSenha***

Objetivo: Iniciar o processo de recuperação de senha para um usuário, enviando instruções para redefinição.

***AtualizarSenha***

Objetivo: Permitir que um usuário mude sua senha após passar pela validação adequada.

**Regras de Negócio:**

1. As senhas devem ser armazenadas de forma segura (ex: hash).
2. O token gerado deve ter um tempo de expiração para garantir a segurança.
3. O sistema deve permitir tentativas limitadas de login para prevenir ataques de força bruta.

# Classe Logs de Login - Será chamada de Login

**Responsabilidades da Classe Logs de Login:**

A classe Logs de Login é responsável por registrar e armazenar informações sobre as tentativas de login dos usuários. Isso inclui tanto logins bem-sucedidos quanto falhos, permitindo auditoria e monitoramento de segurança.

**Atributos:**

id: Identificador único do log de login.
usuario: Nome de usuário ou e-mail do usuário que tentou fazer login ou serviço utilizado como google, direto do cadastro, linkedin ou outros.
dataHora: Data e hora da tentativa de login.

**Métodos:**

***RegistrarLogin***

Objetivo: Armazenar informações sobre uma tentativa de login, incluindo o usuário, data e hora, resultado e IP.

***BuscarLogsPorUsuario***

Objetivo: Recuperar todos os logs de login associados a um usuário específico para auditoria.

***BuscarLogsPorData***

Objetivo: Recuperar logs de login dentro de um intervalo de datas específico para análise.

**Regras de Negócio:**

1. Os logs devem ser armazenados em um formato seguro e acessível apenas a usuários autorizados.
2. Deve haver uma política de retenção para determinar por quanto tempo os logs serão mantidos.
3. Os registros de login falhos devem ser monitorados para identificar possíveis tentativas de ataque.
