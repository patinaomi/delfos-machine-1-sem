
# Modelo Conceitual e Documentação 

## Entidades e Atributos 

**Cliente**
```bash
  ID_Cliente (chave primária) 
  Nome 
  Email 
  Telefone 
  Data_Nascimento 
  Endereço 
```
 
**Clinica**
```bash
ID_Clinica (chave primária) 
Nome 
Endereço 
Telefone 
Avaliacao
Preco_Medio 
```

**Consulta** (Ato do cliente agendar) 
```bash
  ID_Consulta (chave primária) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  dentista_id (ID do dentista responsavel) 
  Tipo_Servico 
  data_consulta (Data da consulta) 
  hora_consulta (Hora da consulta) 
  tipo_consulta (Tipo de consulta: preventiva, tratamento, emergencia) 
  local_consulta (Local da consulta) 
  status_consulta (Status da consulta: agendada, realizada, cancelada) 
  observacoes (Observações sobre a consulta) 
  sintomas (Sintomas apresentados pelo usuario) 
  tratamento_recomendado (Tratamento recomendado apos a consulta) 
  custo (Custo da consulta) 
  forma_pagamento (Forma de pagamento: cartao, dinheiro, convenio) 
  prescricao (Prescrição dada apos a consulta) 
  data_retorno (Data para retorno, se aplicavel) 
```

**Sinistro** (Tratativa do processo interno) 
```bash
  ID_Sinistro (chave primaria) 
  Nome 
  Descricao
  status_sinistro (Status do sinistro: pendente, aprovado, negado) 
  Descricao_status (Se negado por exemplo, precisa mostrar o motivo) 
  valor_sinistro (Valor do sinistro) 
  Data_abertura 
  data_resolucao (Data de resolução do sinistro) 
  documentacao (Se necessario) 
```

**Feedback** – Precisamos pensar que um precisa para medico, outra para consulta, consultorio e App. 
```bash
  ID_Feedback (chave primaria) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  Avaliacao 
  Comentario 
```

**Formulário Detalhado**
```bash
  formulario_id (chave primaria) 
  usuario_id (chave estrangeira) 
  historico_familiar 
  plano_odontologico 
  estado_civil 
  profissao 
  renda_mensal 
  tempo_residencia 
  historico_medico 
  alergias 
  condicoes_preexistentes 
  uso_medicamentos 
  familiar_com_doencas_dentarias 
  participacao_em_programas_preventivos 
  historico_de_fraude – aqui podemos avaliar por exemplo processos judiciais que tem API na internet 
  contatos_emergenciais 
  historico_de_reclamacoes 
  participacao_em_pesquisas 
  data_ultima_atualizacao 
  frequencia_consultas_periodicas 
  sinalizacao_de_risco 
  data_de_nascimento_mae 
  data_de_nascimento_pai 
  horario_preferencia_atendimento 
  Dia_semana_preferencia 
  Preferencia_consulta (presencial ou remota) 
  data_inicio_plano 
  data_fim_plano 
  atividade_fisica (sim ou não) 
```

**Agenda**
```bash
  ID_Agenda (chave primaria) 
  ID_Cliente (chave estrangeira) 
  ID_Consulta (chave estrangeira) 
  Data_Consulta 
  Hora_Consulta 
  Status_Consulta 
  Observacoes 
```

**Notificacoes**
```bash
ID_Notificacao (chave primaria) 
ID_Cliente (chave estrangeira) 
Tipo_Notificacao 
Mensagem 
Data_Envio 
Status_Notificacao 
```

# Relacionamentos 

**Cliente e Consulta**
```bash
Tipo: 1:N (Um cliente pode ter várias consultas) 
Descrição: Cada cliente pode agendar múltiplas consultas ao longo do tempo. 
```

**Clínica e Consulta**
```bash
Tipo: 1:N (Uma clínica pode ter várias consultas) 
Descrição: Cada clínica pode atender a vários clientes em diferentes consultas. 
```

**Consulta e Sinistro**
```bash
Tipo: N:1 (Várias consultas podem estar associadas a um sinistro) 
Descrição: Uma consulta pode gerar um sinistro (por exemplo, quando um tratamento é necessário), mas cada sinistro está associado a uma única consulta. 
```

**Cliente e Feedback**
```bash
Tipo: 1:N (Um cliente pode deixar vários feedbacks) 
Descrição: Cada cliente pode fornecer feedback sobre diversas clínicas, consultas e até mesmo sobre o aplicativo. 
```

**Clínica e Feedback**
```bash
Tipo: 1:N (Uma clínica pode receber vários feedbacks) 
Descrição: Cada clínica pode receber feedback de vários clientes. 
```

**Formulário Detalhado e Usuário**
```bash
Tipo: 1:1 (Um formulário detalhado é associado a um único usuário) 
Descrição: Cada usuário tem um formulário personalizado que coleta informações detalhadas sobre sua saúde e histórico. 
```

**Agenda e Cliente**
```bash
Tipo: N:1 (Muitos agendamentos podem estar associados a um único cliente) 
Descrição: Cada agendamento é relacionado a um cliente específico, que pode ter vários agendamentos. 
```

**Agenda e Consulta**
```bash
Tipo: N:1 (Muitos agendamentos podem estar associados a uma única consulta) 
Descrição: Cada agendamento está vinculado a uma consulta específica, mas uma consulta pode ser referenciada em diferentes agendamentos (como retornos). 
```

**Notificacoes e Cliente**
```bash
Tipo: N:1 (Muitas notificações podem estar associadas a um único cliente) 
Descrição: Cada notificação é enviada a um cliente específico, que pode receber várias notificações. 
```

## Resumo dos Relacionamentos 

Cliente (1) — (N) Consulta – JAVA ONETOMANY 
Clínica (1) — (N) Consulta ONETOMANY 
Consulta (N) — (1) Sinistro MANYTOONE 
Cliente (1) — (N) Feedback ONETOMANY 
Clínica (1) — (N) Feedback ONETOMANY 
Usuário (1) — (1) Formulário Detalhado ONETOONE 
Agenda (N) — (1) Cliente MANYTOONE
Agenda (N) — (1) Consulta MANYTOONE
Notificacoes (N) — (1) Cliente MANYTOONE

# Documentação das Entidades 

**1. Entidade: Cliente**

**Descrição:** Representa os usuários que utilizam os serviços da clínica odontológica. 
**Atributos:**
```bash
ID_Cliente: Identificador único do cliente (chave primária). 
Nome: Nome completo do cliente. 
Email: Endereço de e-mail do cliente para comunicação. 
Telefone: Número de telefone para contato. 
Data_Nascimento: Data de nascimento do cliente. 
Endereço: Endereço residencial do cliente. 
```
**Finalidade:** Armazenar informações pessoais dos clientes para agendamentos, comunicações e gerenciamento de consultas. 

**2. Entidade: Clínica**

**Descrição:** Representa as clínicas odontológicas disponíveis no sistema. 
**Atributos:**
```bash
ID_Clínica: Identificador único da clínica (chave primária). 
Nome: Nome da clínica. 
Endereço: Endereço físico da clínica. 
Telefone: Número de contato da clínica. 
Avaliação: Média das avaliações recebidas da clínica. 
Preço_Médio: Preço médio dos serviços oferecidos pela clínica. 
```
**Finalidade:** Armazenar informações sobre as clínicas para que os clientes possam escolher onde realizar suas consultas. 

**3. Entidade: Consulta**

**Descrição:** Representa cada agendamento de consulta realizado pelo cliente. 
**Atributos:**
```bash
ID_Consulta: Identificador único da consulta (chave primária). 
ID_Cliente: Referência ao cliente que agendou a consulta (chave estrangeira). 
ID_Clínica: Referência à clínica onde a consulta será realizada (chave estrangeira). 
Dentista_ID: Identificador do dentista responsável pela consulta. 
Tipo_Serviço: Tipo de serviço solicitado (limpeza, tratamento, etc.). 
Data_Consulta: Data marcada para a consulta. 
Hora_Consulta: Hora marcada para a consulta. 
Tipo_Consulta: Tipo de consulta (preventiva, tratamento, emergência). 
Local_Consulta: Local onde a consulta será realizada. 
Status_Consulta: Status atual da consulta (agendada, realizada, cancelada). 
Observações: Notas adicionais sobre a consulta. 
Sintomas: Sintomas apresentados pelo cliente. 
Tratamento_Recomendado: Tratamento sugerido pelo dentista. 
Custo: Custo da consulta. 
Forma_Pagamento: Método de pagamento utilizado. 
Prescrição: Prescrição dada após a consulta. 
Data_Retorno: Data para retorno, se aplicável. 
```
**Finalidade:** Gerenciar e registrar todas as informações relacionadas às consultas agendadas pelos clientes. 

**4. Entidade: Sinistro**

**escrição:** Representa a tratativa de processos internos, como sinistros de seguros associados às consultas. 
**Atributos:**
```bash
ID_Sinistro: Identificador único do sinistro (chave primária). 
Nome: Nome associado ao sinistro. 
Descrição: Descrição detalhada do sinistro. 
Status_Sinistro: Status atual do sinistro (pendente, aprovado, negado). 
Descricao_Status: Motivo para um sinistro ser negado, se aplicável. 
Valor_Sinistro: Valor estimado do sinistro. 
Data_Abertura: Data em que o sinistro foi aberto. 
Data_Resolucao: Data em que o sinistro foi resolvido. 
Documentacao: Documentação necessária para tratamento do sinistro. 
```
**Finalidade:** Gerenciar informações sobre sinistros que possam ocorrer em decorrência das consultas ou tratamentos realizados. 

**5. Entidade: Feedback**

**Descrição:** Representa as avaliações e comentários feitos pelos clientes sobre as clínicas e serviços. 
**Atributos:**
```bash
ID_Feedback: Identificador único do feedback (chave primária). 
ID_Cliente: Referência ao cliente que deixou o feedback (chave estrangeira). 
ID_Clínica: Referência à clínica sobre a qual o feedback foi deixado (chave estrangeira). 
Avaliação: Nota atribuída pelo cliente à clínica. 
Comentário: Comentário adicional feito pelo cliente. 
```
**Finalidade:** Coletar e armazenar as opiniões dos clientes sobre as clínicas e serviços, ajudando a melhorar a qualidade e a experiência do atendimento. 

**6. Entidade: Formulário Detalhado**

**Descrição:** Coleta informações detalhadas sobre a saúde e histórico dos usuários. 
**Atributos:**
```bash
formulario_id: Identificador único do formulário (chave primária). 
usuario_id: Referência ao usuário que preencheu o formulário (chave estrangeira). 
historico_familiar: Informações sobre o histórico de saúde da família. 
plano_odontologico: Tipo de plano odontológico do usuário. 
estado_civil: Estado civil do usuário. 
profissao: Profissão do usuário. 
renda_mensal: Renda mensal estimada do usuário. 
tempo_residencia: Tempo de residência no endereço atual. 
historico_medico: Histórico médico relevante do usuário. 
alergias: Alergias conhecidas do usuário. 
condicoes_preexistentes: Condições médicas preexistentes. 
uso_medicamentos: Medicamentos atualmente em uso. 
familiar_com_doencas_dentarias: Informações sobre familiares com doenças dentárias. 
participacao_em_programas_preventivos: Indica se o usuário participa de programas de prevenção. 
historico_de_fraude: Informações sobre fraudes associadas ao usuário. 
contatos_emergenciais: Contatos para emergências. 
historico_de_reclamacoes: Reclamações feitas pelo usuário. 
participacao_em_pesquisas: Indica se o usuário participou de pesquisas de satisfação. 
data_ultima_atualizacao: Data da última atualização dos dados. 
frequencia_consultas_periodicas: Frequência de consultas do usuário. 
sinalizacao_de_risco: Sinalizações de risco associadas ao usuário. 
data_de_nascimento_mae: Data de nascimento da mãe, se relevante. 
data_de_nascimento_pai: Data de nascimento do pai, se relevante. 
historico_de_viagens: Histórico de viagens relevantes. 
historico_de_mudancas_de_endereco: Mudanças de endereço ao longo do tempo. 
preferencias_de_contato: Preferências de comunicação do usuário. 
```
**Finalidade:** Armazenar informações detalhadas sobre a saúde e o histórico dos usuários para um melhor atendimento e personalização dos serviços. 

**Entidade: Agenda**
**Descrição:** Representa os agendamentos de consultas feitas pelos clientes, incluindo detalhes sobre datas, horários e status das consultas. 
**Atributos:** 
```bash
ID_Agenda: Identificador único da agenda (chave primária). 
ID_Cliente: Referência ao cliente que possui o agendamento (chave estrangeira). 
ID_Consulta: Referência à consulta agendada (chave estrangeira). 
Data_Consulta: Data em que a consulta está agendada. 
Hora_Consulta: Hora em que a consulta está agendada. 
Status_Consulta: Status atual da consulta (agendada, realizada, cancelada). 
Observacoes: Notas adicionais sobre o agendamento. 
```
**Finalidade:**
Gerenciar Agendamentos: A tabela Agenda permite armazenar e gerenciar todos os agendamentos dos clientes, facilitando a visualização de datas e horários. 
Acesso Rápido: Permite que os clientes e os administradores do sistema acessem rapidamente as informações sobre consultas agendadas, status e observações. 

**Entidade: Notificacoes**

**Descrição:** Representa as notificações enviadas aos clientes, como e-mails e mensagens via WhatsApp. 
**Atributos:**
```bash
ID_Notificacao: Identificador único da notificação (chave primária). 
ID_Cliente: Referência ao cliente que receberá a notificação (chave estrangeira). 
Tipo_Notificacao: Tipo de notificação enviada (e-mail ou WhatsApp). 
Mensagem: Conteúdo da notificação. 
Data_Envio: Data em que a notificação foi enviada. 
Status_Notificacao: Status atual da notificação (enviada, pendente, falha). 
```
**Finalidade:** Armazenar informações sobre as notificações enviadas aos clientes, permitindo o rastreamento e gerenciamento das comunicações realizadas. 

