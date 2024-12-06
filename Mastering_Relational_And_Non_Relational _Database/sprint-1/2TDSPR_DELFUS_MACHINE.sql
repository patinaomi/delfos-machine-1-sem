-- Nome dos Integrantes: 
-- Claudio Silva Bispo RM553472
-- Patricia Naomi Yamagishi RM552981

-- Deletar tabelas caso já existam

DROP TABLE Notificacao CASCADE CONSTRAINTS;
DROP TABLE Agenda CASCADE CONSTRAINTS;
DROP TABLE Formulario_Detalhado CASCADE CONSTRAINTS;
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE Sinistro CASCADE CONSTRAINTS;
DROP TABLE Consulta CASCADE CONSTRAINTS;
DROP TABLE Dentista CASCADE CONSTRAINTS;
DROP TABLE Especialidade CASCADE CONSTRAINTS;
DROP TABLE Clinica CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Estado_Civil CASCADE CONSTRAINTS;
DROP TABLE Tipo_Notificacao CASCADE CONSTRAINTS;

-- Criação das Tabelas

-- Tabela Cliente 
CREATE TABLE Cliente ( 
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL, 
    sobrenome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) CONSTRAINT email_unique UNIQUE NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    data_nasc DATE NOT NULL, 
    endereco VARCHAR2(255) NOT NULL
); 

-- Tabela Clínica 
CREATE TABLE Clinica ( 
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL, 
    endereco VARCHAR2(255) NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    avaliacao DECIMAL(2, 1) NOT NULL,
    preco_medio DECIMAL(10, 2) NOT NULL
); 

-- Tabela Especialidade
CREATE TABLE Especialidade (
    id_especialidade INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL
);

-- Tabela Dentista
CREATE TABLE Dentista (
    id_dentista INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    sobrenome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(15) NOT NULL,
    id_clinica INTEGER NOT NULL,
    id_especialidade INTEGER NOT NULL,
    avaliacao DECIMAL(2, 1) NOT NULL,
    
    CONSTRAINT fk_dentista_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_dentista_especialidade FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade)
);

-- Tabela Consulta 
CREATE TABLE Consulta ( 
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL, 
    id_clinica INTEGER NOT NULL, 
    id_dentista INTEGER NOT NULL,
    tipo_servico VARCHAR2(100) NOT NULL,
    data_consulta TIMESTAMP NOT NULL, 
    status_consulta CHAR(1), -- 'S' ou 'N'
    observacoes VARCHAR2(250), 
    sintomas VARCHAR2(250), 
    tratamento_recomendado VARCHAR2(250), 
    custo DECIMAL(10, 2),
    prescricao VARCHAR2(250), 
    data_retorno DATE,
    
    CONSTRAINT fk_consulta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_consulta_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_consulta_dentista FOREIGN KEY (id_dentista) REFERENCES Dentista(id_dentista)
);
 
-- Tabela Sinistro
CREATE TABLE Sinistro (
    id_sinistro INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_consulta INTEGER NOT NULL, 
    nome VARCHAR2(100) NOT NULL,
    descricao VARCHAR2(250),
    status_sinistro CHAR(1), -- 'S' ou 'N'
    descricao_status VARCHAR2(250),
    valor_sinistro DECIMAL(10, 2),
    data_abertura DATE NOT NULL,
    data_resolucao DATE,
    documentacao VARCHAR2(250),
    
    CONSTRAINT fk_sinistro_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Feedback
CREATE TABLE Feedback (
    id_feedback INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_dentista INTEGER NOT NULL,
    id_clinica INTEGER NOT NULL,
    avaliacao DECIMAL(2, 1) NOT NULL,
    comentario VARCHAR2(250),
    
    CONSTRAINT fk_feedback_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_feedback_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_feedback_dentista FOREIGN KEY (id_dentista) REFERENCES Dentista(id_dentista)
);
  
-- Tabela Estado Civil
CREATE TABLE Estado_Civil (
    id_estado_civil INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL
);

-- Tabela Formulário Detalhado
CREATE TABLE Formulario_Detalhado (
    id_formulario INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_estado_civil INTEGER NOT NULL,
    historico_familiar VARCHAR2(250),
    profissao VARCHAR2(100),
    renda_mensal DECIMAL(10, 2),
    historico_medico VARCHAR2(250),
    alergia VARCHAR2(250),
    condicao_preexistente VARCHAR2(250),
    uso_medicamento VARCHAR2(250),
    familiar_com_doencas_dentarias VARCHAR2(255),
    participacao_em_programas_preventivos CHAR(1), -- 'Y' ou 'N'
    contato_emergencial VARCHAR2(250),
    pesquisa_satisfacao CHAR(1), -- 'Y' ou 'N'
    data_ultima_atualizacao DATE,
    frequencia_consulta_periodica CHAR(1), -- 'Y' ou 'N'
    sinalizacao_de_risco VARCHAR2(250),
    historico_de_viagem VARCHAR2(250),
    historico_de_mudancas_de_endereco VARCHAR2(250),
    preferencia_de_contato VARCHAR2(50),

    CONSTRAINT fk_formulario_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_formulario_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES Estado_Civil(id_estado_civil)
);

-- Tabela Tipo Notificação
CREATE TABLE Tipo_Notificacao (
    id_tipo_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(40) NOT NULL
);

-- Tabela Agenda
CREATE TABLE Agenda (
    id_agenda INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_consulta INTEGER NOT NULL,
    status_consulta CHAR(1),
    observacoes VARCHAR2(250),

    CONSTRAINT fk_agenda_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_agenda_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Notificações
CREATE TABLE Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_tipo_notificacao INTEGER NOT NULL,
    mensagem VARCHAR2(250),
    data_envio DATE,

    CONSTRAINT fk_notificacao_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_notificacao_tipo FOREIGN KEY (id_tipo_notificacao) REFERENCES Tipo_Notificacao(id_tipo_notificacao)
);
