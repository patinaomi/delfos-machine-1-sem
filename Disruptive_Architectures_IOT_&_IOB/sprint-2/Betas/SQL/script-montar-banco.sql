--Precisa usar seu login e senha do Oracle para realizar essa inserção de dados.


--1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

-- Processo Cliente
DROP TABLE Endereco CASCADE CONSTRAINTS;
DROP TABLE Genero CASCADE CONSTRAINTS;
DROP TABLE EnderecoPreferencia CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE PreferenciaDia CASCADE CONSTRAINTS;
DROP TABLE PreferenciaHorario CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- Fluxo Clinica
DROP TABLE Especialidade CASCADE CONSTRAINTS;
DROP TABLE Especialista CASCADE CONSTRAINTS;
DROP TABLE Clinica CASCADE CONSTRAINTS;
DROP TABLE ClinicaTurno CASCADE CONSTRAINTS;
DROP TABLE ClinicaDia CASCADE CONSTRAINTS;
DROP TABLE ClinicaHorario CASCADE CONSTRAINTS;
DROP TABLE ClinicaEspecialidade CASCADE CONSTRAINTS;
DROP TABLE ClinicaEspecialista CASCADE CONSTRAINTS;

-- Fluxo sugestaoConsulta
DROP TABLE sugestaoConsulta CASCADE CONSTRAINTS;
DROP TABLE statusSugestao CASCADE CONSTRAINTS;
DROP TABLE motivoRecusa CASCADE CONSTRAINTS;
DROP TABLE perfilRecusa CASCADE CONSTRAINTS;

-- Fluxo Consulta
DROP TABLE Consulta CASCADE CONSTRAINTS;
DROP TABLE TipoServico CASCADE CONSTRAINTS;
DROP TABLE Tratamento CASCADE CONSTRAINTS;
DROP TABLE Retorno CASCADE CONSTRAINTS;

-- Fluxo Feedback
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE StatusFeedback CASCADE CONSTRAINTS;

-- Fluxo de Notificação
DROP TABLE notificacao CASCADE CONSTRAINTS;
DROP TABLE tipo_notificacao CASCADE CONSTRAINTS;

-- Fluxo de Sinistro para pagamento
DROP TABLE Sinistro CASCADE CONSTRAINTS;

-- Fluxo para o formulário detalhado. Ficará disponível para a clinica quando a consulta for criada.
DROP TABLE formularioDatalhado CASCADE CONSTRAINTS;
DROP TABLE estadoCivil CASCADE CONSTRAINTS;

-- Salvar a ação de deletar tudo.
commit;

// 2. Criação das tabelas na sequência lógica e que não gere erros.

-- Tabela Endereco (Residencial)

CREATE TABLE Endereco (
    id_endereco INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    numero VARCHAR2(20) NOT NULL
);

-- Tabela Genero

CREATE TABLE Genero (
    id_genero INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- Masculino e Feminino.
);

-- Tabela EnderecoPreferencia (Endereço de Preferência)

CREATE TABLE EnderecoPreferencia (
    id_endereco_preferencia INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    numero VARCHAR2(20) NOT NULL
);

-- Tabela Turno

CREATE TABLE Turno (
    id_turno INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- Manhã, Tarde, Noite
);

-- Tabela PreferenciaDia

CREATE TABLE PreferenciaDia (
    id_preferencia_dia INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    dia VARCHAR2(10) NOT NULL -- 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
);

-- Tabela PreferenciaHorario

CREATE TABLE PreferenciaHorario (
    id_preferencia_horario INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    horario VARCHAR2(5) NOT NULL -- Horários específicos, formato HH:MM (Ex: '06:00', '20:00')
);


-- Tabela Cliente

CREATE TABLE Cliente (
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_completo VARCHAR2(100) NOT NULL, 
    email VARCHAR2(100) CONSTRAINT email_unique UNIQUE NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    data_nasc DATE NOT NULL, -- formato: AAAA-MM-DD
    senha VARCHAR2(15) NOT NULL,
    fk_id_endereco INTEGER, -- FK para o endereço residencial
    fk_id_genero INTEGER, -- FK para a tabela Genero
    fk_id_endereco_preferencia INTEGER, -- FK para o endereço de preferência
    fk_id_turno INTEGER, -- FK para a tabela Turno
    fk_id_preferencia_dia INTEGER, -- FK para a tabela PreferenciaDia
    fk_id_preferencia_horario INTEGER, -- FK para a tabela PreferenciaHorario, pode ser NULL
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (fk_id_endereco) REFERENCES Endereco(id_endereco),
    CONSTRAINT fk_cliente_genero FOREIGN KEY (fk_id_genero) REFERENCES Genero(id_genero),
    CONSTRAINT fk_cliente_endereco_preferencia FOREIGN KEY (fk_id_endereco_preferencia) REFERENCES EnderecoPreferencia(id_endereco_preferencia),
    CONSTRAINT fk_cliente_turno FOREIGN KEY (fk_id_turno) REFERENCES Turno(id_turno),
    CONSTRAINT fk_cliente_preferencia_dia FOREIGN KEY (fk_id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    CONSTRAINT fk_cliente_preferencia_horario FOREIGN KEY (fk_id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario)
);

-- Criação da Tabela Especialidade

CREATE TABLE Especialidade (
    id_especialidade INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL CONSTRAINT especialidade_unique UNIQUE -- Nome da especialidade
);

-- Criação da Tabela Especialista

CREATE TABLE Especialista (
    id_especialista INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    crm VARCHAR2(20) NOT NULL CONSTRAINT crm_unique UNIQUE, -- Registro do conselho regional de medicina
    fk_id_especialidade INTEGER, -- FK para a tabela Especialidade
    CONSTRAINT fk_especialidade FOREIGN KEY (fk_id_especialidade) REFERENCES Especialidade(id_especialidade)
);


-- Criação da Tabela Clinica

CREATE TABLE Clinica (
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    fk_id_endereco INTEGER, -- FK para a tabela Endereco
    CONSTRAINT fk_endereco FOREIGN KEY (fk_id_endereco) REFERENCES Endereco(id_endereco)
);

// Tabelas de relacionamento de Muitos para Muitos

-- ClinicaTurno para estabelecer relação entre os turnos que ela atende (Clinica e tabela Turno)

CREATE TABLE ClinicaTurno (
    id_clinica INTEGER,
    id_turno INTEGER,
    CONSTRAINT fk_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES Turno(id_turno),
    PRIMARY KEY (id_clinica, id_turno)
);

-- Esta tabela relaciona Clinica com PreferenciaDia

CREATE TABLE ClinicaDia (
    id_clinica INTEGER,
    id_preferencia_dia INTEGER,
    CONSTRAINT fk_clinica_relacionamento FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_dia_relacionamento FOREIGN KEY (id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    PRIMARY KEY (id_clinica, id_preferencia_dia)
);

-- Esta tabela relaciona Clinica com PreferenciaHorario

CREATE TABLE ClinicaHorario (
    id_clinica INTEGER,
    id_preferencia_horario INTEGER,
    CONSTRAINT fk_clinica_relacionamento_horario FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_horario_relacionamento FOREIGN KEY (id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario),
    PRIMARY KEY (id_clinica, id_preferencia_horario)
);


-- Esta tabela relaciona Clinica com Especialidade

CREATE TABLE ClinicaEspecialidade (
    id_clinica INTEGER,
    id_especialidade INTEGER,
    CONSTRAINT fk_clinica_relacionamento_especialidade FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_especialidade_relacionamento FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade),
    PRIMARY KEY (id_clinica, id_especialidade)
);


-- Esta tabela relaciona Clinica com Especialista

CREATE TABLE ClinicaEspecialista (
    id_clinica INTEGER,
    id_especialista INTEGER,
    CONSTRAINT fk_clinica_relacionamento_especialista FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_especialista_relacionamento_especialista FOREIGN KEY (id_especialista) REFERENCES Especialista(id_especialista),
    PRIMARY KEY (id_clinica, id_especialista)
);

-- Criação da Tabela TipoServico

CREATE TABLE TipoServico (
    id_tipo_servico INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_tipo_servico VARCHAR2(100) NOT NULL -- 'presencial' ou 'remoto'
);

-- Criação da Tabela Tratamento

CREATE TABLE Tratamento (
    id_tratamento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_tratamento VARCHAR2(255) NOT NULL
);

-- Criação da Tabela Retorno

CREATE TABLE Retorno (
    id_retorno INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_retorno VARCHAR2(50) NOT NULL -- 'Sim' ou 'Não'
);

-- Criação da Tabela Status Feedback

CREATE TABLE StatusFeedback (
    id_status_feedback INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_status VARCHAR2(50) NOT NULL -- 'Respondido' ou 'Não Respondido'
);


-- Criação da Tabela Feedback

CREATE TABLE Feedback (
    id_feedback INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_especialista INTEGER NOT NULL,
    fk_id_clinica INTEGER NOT NULL,
    nota INTEGER NOT NULL, -- nota de 1 até 5
    comentario VARCHAR2(250), -- descrição do feedback
  
    CONSTRAINT fk_feedback_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_feedback_clinica FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_id_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista)
);

-- Criar a tabela status_sugestao
CREATE TABLE statusSugestao (
    id_status_sugestao INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Criar a tabela motivoRecusa
CREATE TABLE motivoRecusa (
    id_motivo_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Criar a tabela status_sugestao
CREATE TABLE perfilRecusa (
    id_perfil_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE -- cliente ou clinica?
);


-- Criar a tabela sugestaoConsulta
CREATE TABLE sugestaoConsulta (
    id_sugestao INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_clinica INTEGER NOT NULL,
    fk_id_especialista INTEGER NOT NULL,
    fk_id_status_sugestao INTEGER NOT NULL,
    fk_id_turno INTEGER NOT NULL,
    fk_id_preferencia_dia INTEGER NOT NULL,
    fk_id_preferencia_horario INTEGER NOT NULL,
    fk_id_tratamento INTEGER NOT NULL,
    fk_perfil_recusa INTEGER NOT NULL,
    fk_id_motivo_recusa INTEGER NOT NULL,
    cliente VARCHAR2(100) NOT NULL,
    descricao_dia_preferencia VARCHAR2(15) NOT NULL,
    descricao_horario_preferencia VARCHAR2(15) NOT NULL,
    descricao_turno VARCHAR2(10) NOT NULL,
    clinica VARCHAR2(100) NOT NULL,
    endereco_clinica VARCHAR2(255) NOT NULL,
    especialista VARCHAR2(100) NOT NULL,
    tratamento VARCHAR2(100) NOT NULL,
    status_sugestao VARCHAR2(15) DEFAULT 'Pendente' NOT NULL,
    custo NUMBER NOT NULL,
    
    -- Definindo as chaves estrangeiras
    FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista),
    FOREIGN KEY (fk_id_turno) REFERENCES Turno(id_turno),
    FOREIGN KEY (fk_id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    FOREIGN KEY (fk_id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario),
    FOREIGN KEY (fk_id_tratamento) REFERENCES Tratamento(id_tratamento),
    FOREIGN KEY (fk_perfil_recusa) REFERENCES perfilRecusa(id_perfil_recusa),
    FOREIGN KEY (fk_id_motivo_recusa) REFERENCES motivoRecusa(id_motivo_recusa)
);


-- Criação da Tabela Consulta

CREATE TABLE Consulta (
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL, 
    fk_id_clinica INTEGER NOT NULL, 
    fk_id_especialista INTEGER NOT NULL,
    fk_id_especialidade INTEGER NOT NULL,
    fk_id_tipo_servico VARCHAR2(100) NOT NULL, -- presencial ou remoto
    data_consulta TIMESTAMP NOT NULL, 
    fk_id_tratamento VARCHAR2(250), -- lista com possiveis tratamentos
    custo DECIMAL(10, 2),
    fk_id_retorno INTEGER, -- se sim ou não. se sim, vai pedir data do retorno.
    data_retorno DATE,
    fk_id_status_feedback INTEGER, -- se foi respondido ou não
    fk_id_feedback INTEGER, -- referência ao feedback dado

    CONSTRAINT fk_consulta_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_consulta_clinica FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_consulta_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista),
    CONSTRAINT fk_consulta_feedback FOREIGN KEY (fk_id_feedback) REFERENCES Feedback(id_feedback),
    CONSTRAINT fk_consulta_retorno FOREIGN KEY (fk_id_retorno) REFERENCES Retorno(id_retorno),
    CONSTRAINT fk_consulta_status_feedback FOREIGN KEY (fk_id_status_feedback) REFERENCES StatusFeedback(id_status_feedback)
);

-- Tabela Sinistro -- processo final quando a consulta finalizou e a seguradora começa a tratar o processo de pagamento

CREATE TABLE Sinistro (
    id_sinistro INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_consulta INTEGER NOT NULL,
    status_sinistro CHAR(1), -- 'S' ou 'N'
    valor_sinistro DECIMAL(10, 2),
    data_abertura DATE NOT NULL, -- data final da consulta, quando o status mudou para finalizada.
    data_resolucao DATE, -- data que o processo foi efetivado o pagamento
    
    CONSTRAINT fk_sinistro_consulta FOREIGN KEY (fk_id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Estado Civil
CREATE TABLE estadoCivil (
    id_estado_civil INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL
);

-- Tabela Preferência de contato
CREATE TABLE preferenciaContato (
    id_preferencia_contato INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- lista com app, sms, whats, ligação
);

-- Tabela Preferência de contato
CREATE TABLE profissao (
    id_profissao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- médico, bombeiro, adm, professor, outros
);

-- Tabela Formulário Detalhado
CREATE TABLE formularioDetalhado (
    id_formulario INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_estado_civil INTEGER NOT NULL,
    fk_id_profissao INTEGER NOT NULL, -- lista de profissao
    fk_id_preferencia_contato INTEGER NOT NULL, -- app, sms, whats, ligação
    historico_familiar VARCHAR2(250),
    renda_mensal DECIMAL(10, 2),
    historico_medico VARCHAR2(250),
    alergia VARCHAR2(3), -- sim ou não
    condicao_preexistente VARCHAR2(250),
    uso_medicamento VARCHAR2(3), -- sim ou não
    familiar_com_doencas_dentarias VARCHAR2(3), -- sim ou não
    participacao_em_programas_preventivos VARCHAR2(3), -- sim ou não
    contato_emergencial VARCHAR2(250), -- telefone
    data_ultima_atualizacao DATE,
    frequencia_consulta_periodica VARCHAR2(3), -- sim ou não
    sinalizacao_de_risco VARCHAR2(3), -- sim ou não
    historico_de_viagem VARCHAR2(3), -- sim ou não
    historico_de_mudancas_de_endereco VARCHAR2(3), -- sim ou não

    CONSTRAINT fk_formulario_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_formulario_estado_civil FOREIGN KEY (fk_id_estado_civil) REFERENCES estadoCivil(id_estado_civil),
    CONSTRAINT fk_id_preferencia_de_contato FOREIGN KEY (fk_id_preferencia_contato) REFERENCES preferenciaContato(id_preferencia_contato),
    CONSTRAINT fk_id_profissao FOREIGN KEY (fk_id_profissao) REFERENCES profissao(id_profissao)
);

-- Salvar os dados de criação
commit;


// 3. Inserir dados no banco para teste

-- Inserindo dados na tabela Endereco

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01000-000', 'SP', 'São Paulo', 'Centro', 'Rua A', '100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('02000-000', 'SP', 'São Paulo', 'Santana', 'Rua B', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03000-000', 'SP', 'São Paulo', 'Brás', 'Rua C', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04000-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua D', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('05000-000', 'SP', 'São Paulo', 'Liberdade', 'Rua E', '500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('06000-000', 'SP', 'São Paulo', 'Mooca', 'Rua F', '600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('07000-000', 'SP', 'São Paulo', 'Itaquera', 'Rua G', '700');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('08000-000', 'SP', 'São Paulo', 'Pirituba', 'Rua H', '800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('09000-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua I', '900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('10000-000', 'SP', 'São Paulo', 'Perdizes', 'Rua J', '1000');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('11000-000', 'SP', 'São Paulo', 'Vila Sônia', 'Rua K', '1100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('12000-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua L', '1200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('13000-000', 'SP', 'São Paulo', 'Butantã', 'Rua M', '1300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('14000-000', 'SP', 'São Paulo', 'Grajaú', 'Rua N', '1400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('15000-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua O', '1500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('16000-000', 'SP', 'São Paulo', 'Vila Prudente', 'Rua P', '1600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('17000-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua Q', '1700');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('18000-000', 'SP', 'São Paulo', 'Jardins', 'Rua R', '1800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('19000-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Rua S', '1900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('20000-000', 'SP', 'São Paulo', 'Chácara Klabin', 'Rua T', '2000');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01001-000', 'SP', 'São Paulo', 'Centro', 'Praça da Sé', '1');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01002-000', 'SP', 'São Paulo', 'Centro', 'Rua da Consolação', '123');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01003-000', 'SP', 'São Paulo', 'Centro', 'Avenida São João', '456');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01004-000', 'SP', 'São Paulo', 'Centro', 'Rua XV de Novembro', '789');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01005-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Glória', '25');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01006-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Paz', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01007-000', 'SP', 'São Paulo', 'Jardins', 'Avenida Rebouças', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01008-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Morais', '1000');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01009-000', 'SP', 'São Paulo', 'Pinheiros', 'Rua dos Três Irmãos', '10');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01010-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Harmonia', '300');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01011-000', 'SP', 'São Paulo', 'Bela Vista', 'Rua da Paz', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01012-000', 'SP', 'São Paulo', 'Vila Gomes Cardim', 'Rua D. João VI', '15');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01013-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '170');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01014-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Avenida João Cachoeira', '150');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01015-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua Dr. Álvaro de Souza Lima', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01016-000', 'SP', 'São Paulo', 'Vila Andrade', 'Rua João Lourenço', '250');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01017-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Serra do Japi', '23');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01018-000', 'SP', 'São Paulo', 'Itaquera', 'Rua Arnaldo de Almeida', '800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01019-000', 'SP', 'São Paulo', 'Lapa', 'Rua Teodoro Sampaio', '900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01020-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Avenida Brigadeiro Luiz Antônio', '1800');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01021-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Rua Domingos Ferreira', '100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01022-000', 'SP', 'São Paulo', 'Jardins', 'Rua da Consolação', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01023-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Avenida Faria Lima', '1500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01024-000', 'SP', 'São Paulo', 'Higienópolis', 'Rua Barão de Capanema', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01025-000', 'SP', 'São Paulo', 'Aclimação', 'Rua Abílio Soares', '10');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01026-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Tuiuti', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01027-000', 'SP', 'São Paulo', 'Saúde', 'Rua Silva Bueno', '250');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01028-000', 'SP', 'São Paulo', 'Vila Sônia', 'Rua São Paulo', '75');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01029-000', 'SP', 'São Paulo', 'Vila Maria', 'Avenida São Miguel', '130');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01030-000', 'SP', 'São Paulo', 'Campo Limpo', 'Rua Doutor Nelson G. Pinto', '400');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04511-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Rua João Cachoeira', '123');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04520-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Avenida Hélio Pellegrino', '456');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04626-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua dos Três Irmãos', '789');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04707-000', 'SP', 'São Paulo', 'Moema', 'Avenida Moaci', '101');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04538-000', 'SP', 'São Paulo', 'Jardins', 'Rua José Maria Lisboa', '202');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04761-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Moraes', '303');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04660-000', 'SP', 'São Paulo', 'Saúde', 'Rua Loefgren', '404');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04562-000', 'SP', 'São Paulo', 'Brooklin', 'Rua Joaquim Nabuco', '505');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04751-000', 'SP', 'São Paulo', 'Chácara Santo Antônio', 'Rua da Paz', '606');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04728-000', 'SP', 'São Paulo', 'Morumbi', 'Avenida Giovanni Gronchi', '707');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04650-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Vergueiro', '810');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04575-000', 'SP', 'São Paulo', 'Moema', 'Rua Normandia', '920');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04712-000', 'SP', 'São Paulo', 'Jardins', 'Rua Estados Unidos', '1234');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04644-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Avenida Brigadeiro Faria Lima', '567');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04730-000', 'SP', 'São Paulo', 'Chácara Santo Antônio', 'Rua Carlos Drummond de Andrade', '890');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04561-000', 'SP', 'São Paulo', 'Vila Andrade', 'Rua Guaporé', '234');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04562-000', 'SP', 'São Paulo', 'Brooklin', 'Rua Gomes de Carvalho', '345');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04765-000', 'SP', 'São Paulo', 'Vila Cordeiro', 'Rua Eduardo F. de Araújo', '456');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04577-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Rua Dr. Renato Paes de Barros', '567');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04753-000', 'SP', 'São Paulo', 'Vila São Francisco', 'Rua das Rosas', '678');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03330-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '120');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03190-000', 'SP', 'São Paulo', 'Brás', 'Rua do Oratório', '55');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03162-000', 'SP', 'São Paulo', 'Vila Prudente', 'Avenida Vila Ema', '320');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03510-000', 'SP', 'São Paulo', 'Sapopemba', 'Rua Paulo Sanches', '350');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03660-000', 'SP', 'São Paulo', 'São Mateus', 'Rua Capela do Socorro', '210');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03460-000', 'SP', 'São Paulo', 'Vila Formosa', 'Rua Tatuí', '175');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03624-000', 'SP', 'São Paulo', 'Penha', 'Rua Azevedo Soares', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03811-000', 'SP', 'São Paulo', 'Ermelino Matarazzo', 'Rua Maringá', '88');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03569-000', 'SP', 'São Paulo', 'Itaquera', 'Avenida Líder', '650');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03803-000', 'SP', 'São Paulo', 'Guaianases', 'Rua Kato', '230');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03476-000', 'SP', 'São Paulo', 'Vila Carrão', 'Rua Emílio de Souza', '45');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03313-000', 'SP', 'São Paulo', 'Parque São Lucas', 'Rua Marechal Rondon', '220');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03478-000', 'SP', 'São Paulo', 'Vila Invernada', 'Rua Joaquim Gonçalves', '350');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03826-000', 'SP', 'São Paulo', 'Vila Santa Terezinha', 'Rua Padre Pedro', '90');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03801-000', 'SP', 'São Paulo', 'São Miguel Paulista', 'Rua do Paraíso', '600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03484-000', 'SP', 'São Paulo', 'Vila Santa Clara', 'Avenida Abrahão de Moraes', '210');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03664-000', 'SP', 'São Paulo', 'Jardim Helena', 'Rua Alice Pereira', '170');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03810-000', 'SP', 'São Paulo', 'Cangaíba', 'Rua Luiz Lacerda', '390');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03329-000', 'SP', 'São Paulo', 'Vila Buarque', 'Rua da Alegria', '45');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03684-000', 'SP', 'São Paulo', 'Vila Sônia', 'Avenida São Miguel', '800');

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01000-000', 'SP', 'São Paulo', 'Centro', 'Rua São Bento', '120');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01001-000', 'SP', 'São Paulo', 'Centro', 'Avenida São João', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01002-000', 'SP', 'São Paulo', 'Centro', 'Praça da Sé', '1');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01003-000', 'SP', 'São Paulo', 'Centro', 'Rua 25 de Março', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01004-000', 'SP', 'São Paulo', 'Centro', 'Avenida Paulista', '1000');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01005-000', 'SP', 'São Paulo', 'Centro', 'Rua da Consolação', '150');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01006-000', 'SP', 'São Paulo', 'Centro', 'Rua Direita', '75');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01007-000', 'SP', 'São Paulo', 'Centro', 'Rua Augusta', '250');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01008-000', 'SP', 'São Paulo', 'Centro', 'Rua Barão de Itapetininga', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01009-000', 'SP', 'São Paulo', 'Centro', 'Avenida Ipiranga', '500');

select * from Endereco;

-- Tabela Genero

INSERT INTO Genero (descricao) VALUES ('Masculino');
INSERT INTO Genero (descricao) VALUES ('Feminino');

select * from Genero;

-- Inserção de Dados na Tabela EnderecoPreferencia

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02010-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Moraes', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02020-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Avenida João Dias', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02030-000', 'SP', 'São Paulo', 'Alto da Lapa', 'Rua Pio XI', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02040-000', 'SP', 'São Paulo', 'Morumbi', 'Rua Doutor Alberto Seabra', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02050-000', 'SP', 'São Paulo', 'Vila Clementino', 'Rua Domingos Ferreira', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02060-000', 'SP', 'São Paulo', 'Vila Andrade', 'Avenida João Dias', '450');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02070-000', 'SP', 'São Paulo', 'Perdizes', 'Rua Monte Alegre', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02080-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua José Maria Whitaker', '550');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02090-000', 'SP', 'São Paulo', 'Pacaembu', 'Avenida Pacaembu', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02100-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Rua da Consolação', '200');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02101-000', 'SP', 'São Paulo', 'Higienópolis', 'Rua Barão de Tatuí', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02102-000', 'SP', 'São Paulo', 'Jardim das Bandeiras', 'Rua Professor Carvalho', '75');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02103-000', 'SP', 'São Paulo', 'Santa Cecília', 'Avenida São João', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02104-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Glória', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02105-000', 'SP', 'São Paulo', 'Moema', 'Avenida Moaci', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02106-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua dos Três Irmãos', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02107-000', 'SP', 'São Paulo', 'Ipanema', 'Rua Pedro de Toledo', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02108-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Harmonia', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02109-000', 'SP', 'São Paulo', 'Jardim São Paulo', 'Rua Pedro Vicente', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02110-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Rua Itápolis', '300');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02111-000', 'SP', 'São Paulo', 'Pirituba', 'Rua Desembargador Paulo Duran', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02112-000', 'SP', 'São Paulo', 'Brooklin', 'Rua João Freire', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02113-000', 'SP', 'São Paulo', 'Cangaíba', 'Avenida Alberto Ramos', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02114-000', 'SP', 'São Paulo', 'São Miguel Paulista', 'Rua Jardim São Paulo', '100');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02115-000', 'SP', 'São Paulo', 'Brás', 'Rua São Caetano', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02116-000', 'SP', 'São Paulo', 'Lapa', 'Rua Guaicurus', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02117-000', 'SP', 'São Paulo', 'Saúde', 'Avenida Doutor Ricardo Jafet', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02118-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Vergueiro', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02119-000', 'SP', 'São Paulo', 'Vila Formosa', 'Rua Arnaldo Pires de Almeida', '80');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02120-000', 'SP', 'São Paulo', 'Itaquera', 'Avenida Aricanduva', '1000');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02121-000', 'SP', 'São Paulo', 'Jardim São Paulo', 'Rua Álvaro Ramos', '75');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02122-000', 'SP', 'São Paulo', 'Vila Progredior', 'Rua Progresso', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02123-000', 'SP', 'São Paulo', 'Tatuapé', 'Avenida Celso Garcia', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02124-000', 'SP', 'São Paulo', 'Vila Carrão', 'Rua Apucarana', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02125-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua João Moura', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02126-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02127-000', 'SP', 'São Paulo', 'Pacaembu', 'Rua João Ramalho', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02128-000', 'SP', 'São Paulo', 'Bela Vista', 'Rua da Consolação', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02129-000', 'SP', 'São Paulo', 'Barra Funda', 'Rua Peixoto Gomide', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02130-000', 'SP', 'São Paulo', 'Santana', 'Rua Voluntários da Pátria', '700');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02131-000', 'SP', 'São Paulo', 'Jardim Angela', 'Rua José Rocco', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02132-000', 'SP', 'São Paulo', 'Lapa', 'Rua da Lapa', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02133-000', 'SP', 'São Paulo', 'Vila Pompéia', 'Rua Pompéia', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02134-000', 'SP', 'São Paulo', 'Capão Redondo', 'Rua Mairiporã', '450');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02135-000', 'SP', 'São Paulo', 'Perus', 'Rua Fagundes', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02136-000', 'SP', 'São Paulo', 'São Miguel', 'Rua São Miguel', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02137-000', 'SP', 'São Paulo', 'Ipiranga', 'Rua do Lago', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02138-000', 'SP', 'São Paulo', 'Vila Joaniza', 'Rua Eduardo Gomes', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02139-000', 'SP', 'São Paulo', 'Vila Andrade', 'Rua São Bartolomeu', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02140-000', 'SP', 'São Paulo', 'Tremembé', 'Rua Tremembé', '500');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03151-000', 'SP', 'São Paulo', 'Vila Carrão', 'Rua José do Patrocínio', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03152-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03153-000', 'SP', 'São Paulo', 'Belém', 'Avenida Celso Garcia', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03154-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Tuiuti', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03155-000', 'SP', 'São Paulo', 'Penha', 'Rua Carlos Gomes', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03156-000', 'SP', 'São Paulo', 'São Mateus', 'Rua Doutor Antonio de Barros', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03157-000', 'SP', 'São Paulo', 'Itaquera', 'Avenida do Contorno', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03158-000', 'SP', 'São Paulo', 'Guaianases', 'Rua São Francisco', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03159-000', 'SP', 'São Paulo', 'Jardim Helena', 'Rua dos Três Irmãos', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03160-000', 'SP', 'São Paulo', 'Vila Ré', 'Rua Arataca', '150');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03161-000', 'SP', 'São Paulo', 'Vila Prudente', 'Avenida Anhaia Mello', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03162-000', 'SP', 'São Paulo', 'Sapopemba', 'Rua São Jorge', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03163-000', 'SP', 'São Paulo', 'Jardim Angela', 'Rua das Aroeiras', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03164-000', 'SP', 'São Paulo', 'Vila Matilde', 'Rua Professor Antonio Sanches', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03165-000', 'SP', 'São Paulo', 'Ermelino Matarazzo', 'Rua Dr. Eduardo de Souza', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03166-000', 'SP', 'São Paulo', 'Parque do Carmo', 'Avenida Dr. José M. R. de Oliveira', '700');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03167-000', 'SP', 'São Paulo', 'Cidade Tiradentes', 'Rua das Flores', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03168-000', 'SP', 'São Paulo', 'Vila Curuçá', 'Rua Curuçá', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03169-000', 'SP', 'São Paulo', 'Itaquera', 'Rua Guaianazes', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('03170-000', 'SP', 'São Paulo', 'Vila Ema', 'Rua Ferreira de Araújo', '350');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05031-000', 'SP', 'São Paulo', 'Vila Romana', 'Rua Bartira', '100');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05032-000', 'SP', 'São Paulo', 'Pinheiros', 'Avenida Rebouças', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05033-000', 'SP', 'São Paulo', 'Butantã', 'Rua Alvarenga', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05034-000', 'SP', 'São Paulo', 'Lapa', 'Rua do Lavradio', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05035-000', 'SP', 'São Paulo', 'Vila Leopoldina', 'Avenida Imperatriz Leopoldina', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05036-000', 'SP', 'São Paulo', 'Jardim das Bandeiras', 'Rua das Bandeiras', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05037-000', 'SP', 'São Paulo', 'Vila São Francisco', 'Rua São Francisco', '700');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05038-000', 'SP', 'São Paulo', 'Jardim da Saúde', 'Rua Dr. Miguel D. de Almeida', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05039-000', 'SP', 'São Paulo', 'Morumbi', 'Avenida Professor Francisco Morato', '900');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05040-000', 'SP', 'São Paulo', 'Alto da Lapa', 'Rua Carlos Wagner', '1000');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05041-000', 'SP', 'São Paulo', 'Vila dos Remédios', 'Rua das Indústrias', '110');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05042-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Wizard', '120');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05043-000', 'SP', 'São Paulo', 'Vila Itororó', 'Rua Itororó', '130');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05044-000', 'SP', 'São Paulo', 'Jardim Paulistano', 'Rua Gomes de Carvalho', '140');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05045-000', 'SP', 'São Paulo', 'Jardim Panorama', 'Rua Arara', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05046-000', 'SP', 'São Paulo', 'Vila Sônia', 'Rua da Aldeia', '160');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05047-000', 'SP', 'São Paulo', 'Jardim das Acácias', 'Rua das Acácias', '170');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05048-000', 'SP', 'São Paulo', 'Jardim São Jorge', 'Rua São Jorge', '180');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05049-000', 'SP', 'São Paulo', 'Vila São Francisco', 'Rua Cândido Mendes', '190');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('05050-000', 'SP', 'São Paulo', 'Alto de Pinheiros', 'Rua Cardoso Pimentel', '200');

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02011-000', 'SP', 'São Paulo', 'Tucuruvi', 'Avenida Tucuruvi', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02012-000', 'SP', 'São Paulo', 'Santana', 'Rua Voluntários da Pátria', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02013-000', 'SP', 'São Paulo', 'Mandaqui', 'Rua Mandaqui', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02014-000', 'SP', 'São Paulo', 'Cachoeirinha', 'Rua da Cachoeira', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02015-000', 'SP', 'São Paulo', 'Jaçanã', 'Rua do Jaçanã', '450');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02016-000', 'SP', 'São Paulo', 'Tremembé', 'Rua Cândido Mendes', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02017-000', 'SP', 'São Paulo', 'Jardim França', 'Rua Jardins da França', '550');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02018-000', 'SP', 'São Paulo', 'Parada Inglesa', 'Avenida Parada Inglesa', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02019-000', 'SP', 'São Paulo', 'Vila Guilherme', 'Rua Guilherme', '650');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02020-000', 'SP', 'São Paulo', 'Freguesia do Ó', 'Rua da Freguesia', '700');

select * from EnderecoPreferencia;

-- Inserts para a Tabela Turno

INSERT INTO Turno (descricao) VALUES ('Manhã');
INSERT INTO Turno (descricao) VALUES ('Tarde');
INSERT INTO Turno (descricao) VALUES ('Noite');

select * from Turno;

-- Inserts para a Tabela PreferenciaDia

INSERT INTO PreferenciaDia (dia) VALUES ('Segunda');
INSERT INTO PreferenciaDia (dia) VALUES ('Terça');
INSERT INTO PreferenciaDia (dia) VALUES ('Quarta');
INSERT INTO PreferenciaDia (dia) VALUES ('Quinta');
INSERT INTO PreferenciaDia (dia) VALUES ('Sexta');
INSERT INTO PreferenciaDia (dia) VALUES ('Sábado');
INSERT INTO PreferenciaDia (dia) VALUES ('Domingo');

select * from PreferenciaDia;

-- Inserts para a Tabela PreferenciaHorario

INSERT INTO PreferenciaHorario (horario) VALUES ('06:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('07:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('08:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('09:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('10:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('11:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('12:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('13:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('14:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('15:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('16:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('17:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('18:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('19:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('20:00');

select * from PreferenciaHorario;

-- Inserts para a Tabela Cliente

select * from Cliente;

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Carlos Silva', 'carlos.silva@example.com', '11987654321', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 1, 1, 1, 1, 1, 1, '12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Maria Oliveira', 'maria.oliveira@example.com', '11987654322', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 2, 2, 2, 2, 2, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('João Pereira', 'joao.pereira@example.com', '11987654323', TO_DATE('1992-11-30', 'YYYY-MM-DD'), 3, 1, 3, 3, 3, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ana Costa', 'ana.costa@example.com', '11987654324', TO_DATE('1995-03-10', 'YYYY-MM-DD'), 4, 2, 4, 1, 4, 9,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Lucas Santos', 'lucas.santos@example.com', '11987654325', TO_DATE('1988-09-21', 'YYYY-MM-DD'), 5, 1, 5, 2, 5, 8,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Fernanda Lima', 'fernanda.lima@example.com', '11987654326', TO_DATE('1993-07-22', 'YYYY-MM-DD'), 6, 2, 6, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ricardo Almeida', 'ricardo.almeida@example.com', '11987654327', TO_DATE('1990-12-05', 'YYYY-MM-DD'), 7, 1, 7, 2, 2, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Tatiane Rocha', 'tatiane.rocha@example.com', '11987654328', TO_DATE('1996-04-18', 'YYYY-MM-DD'), 8, 2, 8, 3, 3, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Bruno Mendes', 'bruno.mendes@example.com', '11987654329', TO_DATE('1987-08-12', 'YYYY-MM-DD'), 9, 1, 9, 1, 4, 5,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Juliana Ferreira', 'juliana.ferreira@example.com', '11987654330', TO_DATE('1991-06-30', 'YYYY-MM-DD'), 10, 2, 10, 2, 5, 12,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Diego Cardoso', 'diego.cardoso@example.com', '11987654331', TO_DATE('1989-02-15', 'YYYY-MM-DD'), 11, 1, 11, 3, 1, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Patrícia Souza', 'patricia.souza@example.com', '11987654332', TO_DATE('1986-11-28', 'YYYY-MM-DD'), 12, 2, 12, 1, 2, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Gustavo Silva', 'gustavo.silva@example.com', '11987654333', TO_DATE('1984-05-05', 'YYYY-MM-DD'), 13, 1, 13, 2, 3, 8,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Camila Lima', 'camila.lima@example.com', '11987654334', TO_DATE('1994-09-09', 'YYYY-MM-DD'), 14, 2, 14, 3, 4, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Leonardo Martins', 'leonardo.martins@example.com', '11987654335', TO_DATE('1992-01-01', 'YYYY-MM-DD'), 15, 1, 15, 1, 5, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Renata Barbosa', 'renata.barbosa@example.com', '11987654336', TO_DATE('1987-03-22', 'YYYY-MM-DD'), 16, 2, 16, 2, 1, 9,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Samuel Almeida', 'samuel.almeida@example.com', '11987654337', TO_DATE('1995-06-30', 'YYYY-MM-DD'), 17, 1, 17, 3, 2, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Mariana Costa', 'mariana.costa@example.com', '11987654338', TO_DATE('1989-02-11', 'YYYY-MM-DD'), 18, 2, 18, 1, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Thiago Mendes', 'thiago.mendes@example.com', '11987654339', TO_DATE('1988-12-25', 'YYYY-MM-DD'), 19, 1, 19, 2, 4, 9,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Isabela Santos', 'isabela.santos@example.com', '11987654340', TO_DATE('1990-04-19', 'YYYY-MM-DD'), 20, 2, 20, 3, 5, 15,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Paulo Henrique', 'paulo.henrique@example.com', '11987654341', TO_DATE('1991-08-15', 'YYYY-MM-DD'), 21, 1, 21, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Luciana Ferreira', 'luciana.ferreira@example.com', '11987654342', TO_DATE('1986-11-28', 'YYYY-MM-DD'), 22, 2, 1, 2, 2, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Felipe Carvalho', 'felipe.carvalho@example.com', '11987654343', TO_DATE('1985-10-07', 'YYYY-MM-DD'), 23, 1, 2, 3, 3, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('André Oliveira', 'andre.oliveira@example.com', '11987654344', TO_DATE('1995-03-12', 'YYYY-MM-DD'), 24, 1, 24, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Monique Silva', 'monique.silva@example.com', '11987654345', TO_DATE('1998-06-20', 'YYYY-MM-DD'), 25, 2, 25, 2, 2, 11,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Lucas Ferreira', 'lucas.ferreira@example.com', '11987654346', TO_DATE('1992-08-15', 'YYYY-MM-DD'), 26, 1, 26, 3, 3, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Natália Costa', 'natalia.costa@example.com', '11987654347', TO_DATE('1994-02-05', 'YYYY-MM-DD'), 27, 2, 27, 1, 4, 5,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Rafael Gomes', 'rafael.gomes@example.com', '11987654348', TO_DATE('1993-11-30', 'YYYY-MM-DD'), 28, 1, 28, 2, 5, 11,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Sofia Santos', 'sofia.santos@example.com', '11987654349', TO_DATE('1997-07-22', 'YYYY-MM-DD'), 29, 2, 29, 3, 1, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Thiago Lima', 'thiago.lima@example.com', '11987654350', TO_DATE('1988-05-11', 'YYYY-MM-DD'), 30, 1, 30, 1, 2, 3,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Gabi Pereira', 'gabi.pereira@example.com', '11987654351', TO_DATE('1990-10-17', 'YYYY-MM-DD'), 31, 2, 31, 2, 3, 10,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Matheus Rocha', 'matheus.rocha@example.com', '11987654352', TO_DATE('1991-01-09', 'YYYY-MM-DD'), 32, 1, 32, 3, 4, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Fernanda Martins', 'fernanda.martins@example.com', '11987654353', TO_DATE('1995-06-21', 'YYYY-MM-DD'), 33, 2,33, 1, 5, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Eduardo Almeida', 'eduardo.almeida@example.com', '11987654354', TO_DATE('1996-03-15', 'YYYY-MM-DD'), 34, 1, 34, 2, 1, 8,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Carla Santos', 'carla.santos@example.com', '11987654355', TO_DATE('1989-12-11', 'YYYY-MM-DD'), 35, 2, 35, 3, 2, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Gabriel Costa', 'gabriel.costa@example.com', '11987654356', TO_DATE('1994-04-22', 'YYYY-MM-DD'), 36, 1, 36, 1, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Camila Almeida', 'camila.almeida@example.com', '11987654357', TO_DATE('1993-10-05', 'YYYY-MM-DD'), 37, 2, 37, 2, 4, 5,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Mariana Lima', 'mariana.lima@example.com', '11987654359', TO_DATE('1992-09-29', 'YYYY-MM-DD'), 38, 2, 38, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('José Almeida', 'jose.almeida@example.com', '11987654360', TO_DATE('1996-07-17', 'YYYY-MM-DD'), 39, 1, 39, 2, 2, 9,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Aline Martins', 'aline.martins@example.com', '11987654361', TO_DATE('1990-05-21', 'YYYY-MM-DD'), 40, 2, 40, 3, 3, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Samuel Rocha', 'samuel.rocha@example.com', '11987654362', TO_DATE('1989-11-10', 'YYYY-MM-DD'), 41, 1, 41, 1, 4, 5,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Tânia Mendes', 'tania.mendes@example.com', '11987654363', TO_DATE('1991-08-25', 'YYYY-MM-DD'), 42, 2, 42, 2, 5, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Cláudia Dias', 'claudia.dias@example.com', '11987654365', TO_DATE('1994-12-12', 'YYYY-MM-DD'), 44, 2, 44, 1, 2, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Felipe Gomes', 'felipe.gomes@example.com', '11987654366', TO_DATE('1990-03-18', 'YYYY-MM-DD'), 45, 1, 45, 2, 3, 11,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Beatriz Costa', 'beatriz.costa@example.com', '11987654367', TO_DATE('1987-09-03', 'YYYY-MM-DD'), 46, 2, 46, 3, 4, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Bruno Santos', 'bruno.santos@example.com', '11987654368', TO_DATE('1993-10-25', 'YYYY-MM-DD'), 47, 1, 47, 1, 5, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Larissa Almeida', 'larissa.almeida@example.com', '11987654369', TO_DATE('1998-02-14', 'YYYY-MM-DD'), 48, 2, 48, 2, 1, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Eduardo Silva', 'eduardo.silva@example.com', '11987654370', TO_DATE('1991-01-29', 'YYYY-MM-DD'), 49, 1, 49, 3, 2, 14,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Patrícia Rocha', 'patricia.rocha@example.com', '11987654371', TO_DATE('1992-05-20', 'YYYY-MM-DD'), 50, 2, 50, 1, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ricardo Mendes', 'ricardo.mendes@example.com', '11987654372', TO_DATE('1990-07-04', 'YYYY-MM-DD'), 51, 1, 51, 2, 4, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Sérgio Santos', 'sergio.santos@example.com', '11987654374', TO_DATE('1986-03-21', 'YYYY-MM-DD'), 52, 1, 52, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Amanda Ferreira', 'amanda.ferreira@example.com', '11987654375', TO_DATE('1995-09-18', 'YYYY-MM-DD'), 53, 2, 53, 2, 2, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Tatiane Alves', 'tatiane.alves@example.com', '11987654376', TO_DATE('1990-12-01', 'YYYY-MM-DD'), 54, 2, 54, 1, 1, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Juliana Rocha', 'juliana.rocha@example.com', '11987654378', TO_DATE('1992-08-10', 'YYYY-MM-DD'), 55, 2, 55, 3, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Gabriel Santos', 'gabriel.santos@example.com', '11987654379', TO_DATE('1988-02-24', 'YYYY-MM-DD'), 56, 1, 56, 1, 4, 5,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ana Clara Lima', 'anaclara.lima@example.com', '11987654380', TO_DATE('1995-03-30', 'YYYY-MM-DD'), 57, 2, 57, 2, 5, 11,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Renan Mendes', 'renan.mendes@example.com', '11987654381', TO_DATE('1990-06-18', 'YYYY-MM-DD'), 58, 1, 58, 3, 1, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Isabela Oliveira', 'isabela.oliveira@example.com', '11987654382', TO_DATE('1997-09-29', 'YYYY-MM-DD'), 59, 2, 59, 1, 2, 3,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Matheus Pereira', 'matheus.pereira@example.com', '11987654383', TO_DATE('1991-01-14', 'YYYY-MM-DD'), 60, 1, 60, 2, 3, 8,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Jéssica Costa', 'jessica.costa@example.com', '11987654384', TO_DATE('1994-04-11', 'YYYY-MM-DD'), 61, 2, 61, 3, 4, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Thiago Martins', 'thiago.martins@example.com', '11987654385', TO_DATE('1996-11-05', 'YYYY-MM-DD'), 62, 1, 62, 1, 5, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Simone Nascimento', 'simone.nascimento@example.com', '11987654386', TO_DATE('1989-02-20', 'YYYY-MM-DD'), 63, 2, 63, 2, 1, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Fernando Almeida', 'fernando.almeida@example.com', '11987654387', TO_DATE('1993-07-17', 'YYYY-MM-DD'), 64, 1, 64, 3, 2, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Camila Gomes', 'camila.gomes@example.com', '11987654388', TO_DATE('1992-10-24', 'YYYY-MM-DD'), 65, 2, 65, 1, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('João Vitor Sousa', 'joaovitor.sousa@example.com', '11987654389', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 66, 1, 66, 2, 4, 8,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Larissa Martins', 'larissa.martins@example.com', '11987654390', TO_DATE('1987-03-09', 'YYYY-MM-DD'), 67, 2, 67, 3, 5, 15,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('André Santos', 'andre.santos@example.com', '11987654391', TO_DATE('1994-12-28', 'YYYY-MM-DD'), 68, 1, 68, 1, 1, 2,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Bianca Rodrigues', 'bianca.rodrigues@example.com', '11987654392', TO_DATE('1990-06-15', 'YYYY-MM-DD'), 69, 2, 69, 2, 2, 13,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Eduarda Ferreira', 'eduarda.ferreira@example.com', '11987654393', TO_DATE('1989-09-10', 'YYYY-MM-DD'), 70, 1, 70, 3, 3, 14,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ana Clara', 'ana.clara@example.com', '11999999902', TO_DATE('1995-02-20', 'YYYY-MM-DD'), 71, 2, 71, 2, 2, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('João Paulo', 'joao.paulo@example.com', '11999999903', TO_DATE('1988-03-25', 'YYYY-MM-DD'), 72, 1, 72, 1, 3, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Mariana Ferreira', 'mariana.ferreira@example.com', '11999999904', TO_DATE('1992-04-30', 'YYYY-MM-DD'), 73, 2, 73, 2, 4, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Carla Mendes', 'carla.mendes@example.com', '11999999906', TO_DATE('1993-06-10', 'YYYY-MM-DD'), 74, 2, 74, 2, 1, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Ricardo Oliveira', 'ricardo.oliveira@example.com', '11999999907', TO_DATE('1987-07-15', 'YYYY-MM-DD'), 75, 1, 75, 1, 2, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Juliana Costa', 'juliana.costa@example.com', '11999999908', TO_DATE('1991-08-20', 'YYYY-MM-DD'), 76, 2, 76, 2, 3, 9,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Roberto Silva', 'roberto.silva@example.com', '11999999909', TO_DATE('1986-09-25', 'YYYY-MM-DD'), 77, 1, 77, 1, 4, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Patrícia Lima', 'patricia.lima@example.com', '11999999910', TO_DATE('1994-10-30', 'YYYY-MM-DD'), 78, 2, 78, 2, 5, 10,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Marcos Paulo', 'marcos.paulo@example.com', '11999999911', TO_DATE('1983-11-05', 'YYYY-MM-DD'), 79, 1, 79, 1, 6, 3,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Fernanda Sousa', 'fernanda.sousa@example.com', '11999999912', TO_DATE('1990-12-10', 'YYYY-MM-DD'), 80, 2, 80, 2, 7, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Vinícius Cardoso', 'vinicius.cardoso@example.com', '11999999913', TO_DATE('1992-01-15', 'YYYY-MM-DD'), 81, 1, 81, 1, 1, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Beatriz Rocha', 'beatriz.rocha@example.com', '11999999914', TO_DATE('1989-02-20', 'YYYY-MM-DD'), 82, 2, 82, 2, 2, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Diego Nascimento', 'diego.nascimento@example.com', '11999999915', TO_DATE('1988-03-25', 'YYYY-MM-DD'), 83, 1, 83, 1, 3, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Sofia Almeida', 'sofia.almeida@example.com', '11999999916', TO_DATE('1994-04-30', 'YYYY-MM-DD'), 84, 2, 84, 2, 4, 9,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Isabela Dias', 'isabela.dias@example.com', '11999999918', TO_DATE('1987-06-10', 'YYYY-MM-DD'), 85, 2, 85, 2, 1, 10,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Amanda Ribeiro', 'amanda.ribeiro@example.com', '11999999920', TO_DATE('1995-08-20', 'YYYY-MM-DD'), 86, 2, 86, 2, 3, 4,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Leandro Pires', 'leandro.pires@example.com', '11999999921', TO_DATE('1992-09-15', 'YYYY-MM-DD'), 87, 1, 87, 1, 1, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Juliana Martins', 'juliana.martins@example.com', '11999999922', TO_DATE('1990-10-20', 'YYYY-MM-DD'), 88, 2, 88, 2, 2, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Victor Hugo', 'victor.hugo@example.com', '11999999923', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 89, 1, 89, 1, 3, 3,'12345678');

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Natalia Silva', 'natalia.silva@example.com', '11999999924', TO_DATE('1993-12-30', 'YYYY-MM-DD'), 90, 2, 90, 2, 4, 13,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Fábio Costa', 'fabio.costa@example.com', '11999999925', TO_DATE('1985-01-05', 'YYYY-MM-DD'), 91, 1, 91, 1, 5, 1,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Simone Rocha', 'simone.rocha@example.com', '11999999926', TO_DATE('1991-02-10', 'YYYY-MM-DD'), 92, 2, 92, 2, 1, 12,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Henrique Almeida', 'henrique.almeida@example.com', '11999999927', TO_DATE('1994-03-15', 'YYYY-MM-DD'), 93, 1, 93, 1, 2, 3,'12345678');
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario, senha) VALUES ('Tânia Martins', 'tania.martins@example.com', '11999999928', TO_DATE('1990-04-20', 'YYYY-MM-DD'), 94, 2, 94, 2, 3, 8,'12345678');

select * from Cliente;

-- Inserts para a Tabela Especialidade

INSERT INTO Especialidade (nome) VALUES ('Odontologia');
INSERT INTO Especialidade (nome) VALUES ('Ortodontia');
INSERT INTO Especialidade (nome) VALUES ('Endodontia');
INSERT INTO Especialidade (nome) VALUES ('Periodontia');
INSERT INTO Especialidade (nome) VALUES ('Implantodontia');
INSERT INTO Especialidade (nome) VALUES ('Cirurgia Bucomaxilofacial');
INSERT INTO Especialidade (nome) VALUES ('Pediatria Odontológica');
INSERT INTO Especialidade (nome) VALUES ('Odontologia Estética');
INSERT INTO Especialidade (nome) VALUES ('Dentística');
INSERT INTO Especialidade (nome) VALUES ('Prostodontia');

select * from Especialidade;

-- Inserts para a Tabela Especialista

INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. João Silva', '123456', 1);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Maria Oliveira', '234567', 2);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Carlos Santos', '345678', 3);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Ana Costa', '456789', 4);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Pedro Almeida', '567890', 5);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Fernanda Lima', '678901', 6);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Roberto Ferreira', '789012', 7);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Juliana Rocha', '890123', 8);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Ricardo Mendes', '901234', 9);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Tatiane Martins', '012345', 10);

select * from Especialista;

-- Inserts para a Tabela Clinica

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Saúde e Sorriso', '11-1234-5678', 'contato@saudesorriso.com.br', 1);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoPlus', '11-2345-6789', 'contato@odontoplus.com.br', 2);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Estar', '11-3456-7890', 'info@bemenstar.com.br', 3);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica DentalCare', '11-4567-8901', 'suporte@dentalcare.com.br', 4);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Feliz', '11-5678-9012', 'atendimento@sorrisofeliz.com.br', 5);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Nova Vida', '11-6789-0123', 'contato@novavida.com.br', 6);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoCenter', '11-7890-1234', 'info@odontocenter.com.br', 7);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Família Saudável', '11-8901-2345', 'contato@familiasaudavel.com.br', 8);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso do Futuro', '11-9012-3456', 'suporte@sorrisodofuturo.com.br', 9);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Vida Nova', '11-0123-4567', 'contato@vidanova.com.br', 10);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Saúde Integral', '11-2341-5678', 'contato@saudeintegral.com.br', 11);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Cuidar', '11-3452-6789', 'contato@bemcuidar.com.br', 12);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Saudável', '11-4563-7890', 'info@sorrisosaudavel.com.br', 13);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoSorriso', '11-5674-8901', 'suporte@odontosorriso.com.br', 14);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Novo Sorriso', '11-6785-9012', 'atendimento@novosorriso.com.br', 15);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Bem', '11-7896-0123', 'contato@vivabem.com.br', 16);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica DentalPro', '11-8907-1234', 'info@dentalpro.com.br', 17);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Saúde e Alegria', '11-9018-2345', 'contato@saudeealegria.com.br', 18);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Brilhante', '11-0129-3456', 'suporte@sorrisobrilhante.com.br', 19);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Vida Plena', '11-1230-4567', 'contato@vidaplena.com.br', 20);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Mais', '11-2341-6789', 'contato@dentalmais.com.br', 21);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Encantado', '11-3452-7890', 'info@sorrisoencantado.com.br', 22);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Fácil', '11-4563-8901', 'contato@odontofacil.com.br', 23);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Sorrir', '11-5674-9012', 'suporte@bemsorrir.com.br', 24);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Nova Odonto', '11-6785-0123', 'atendimento@novaodonto.com.br', 25);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Perfeito', '11-7896-1234', 'contato@sorrisoperfeito.com.br', 26);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Sorrir', '11-8907-2345', 'info@vivasorrir.com.br', 27);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Sorriso', '11-9018-3456', 'contato@dentalsorriso.com.br', 28);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Cuidado Dental', '11-0129-4567', 'suporte@cuidadodental.com.br', 29);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso do Dia', '11-1230-5678', 'contato@sorrisododia.com.br', 30);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Prime', '11-2342-6789', 'contato@dentalprime.com.br', 31);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Brilho', '11-3453-7890', 'info@odontobrilho.com.br', 32);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Ideal', '11-4564-8901', 'contato@sorrisoideal.com.br', 33);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoMax', '11-5675-9012', 'suporte@odontomax.com.br', 34);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Vital', '11-6786-0123', 'atendimento@sorrisovital.com.br', 35);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Vida', '11-7897-1234', 'contato@odontovida.com.br', 36);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Sorrir', '11-8908-2345', 'info@bemsorrir.com.br', 37);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Estética', '11-9019-3456', 'contato@dentalestetica.com.br', 38);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Plus', '11-0130-4567', 'suporte@sorrisoplus.com.br', 39);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Odonto', '11-1241-5678', 'contato@vivaodonto.com.br', 40);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Brilhante', '11-1122-3344', 'contato@sorrisobrilhante.com.br', 41);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Viver', '11-2233-4455', 'info@bemviver.com.br', 42);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoTop', '11-3344-5566', 'suporte@odontotop.com.br', 43);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Mais', '11-4455-6677', 'contato@vivamais.com.br', 44);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Alegre', '11-5566-7788', 'info@sorrisoalegre.com.br', 45);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Vida Nova', '11-6677-8899', 'contato@odontovidanova.com.br', 46);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Total', '11-7788-9900', 'suporte@sorrisototal.com.br', 47);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Forte', '11-8899-0011', 'contato@dentalforte.com.br', 48);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Vivo', '11-9900-1122', 'info@sorrisovivo.com.br', 49);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Futura', '11-0011-2233', 'contato@odontofutura.com.br', 50);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Clean', '11-1234-4321', 'contato@dentalclean.com.br', 51);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Encantado', '11-2345-5432', 'info@sorrisoencantado.com.br', 52);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoExpert', '11-3456-6543', 'contato@odontoexpert.com.br', 53);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Smile', '11-4567-7654', 'info@dentalsmile.com.br', 54);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Sorriso', '11-5678-8765', 'contato@odontosorriso.com.br', 55);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Novo', '11-6789-9876', 'suporte@sorrisnovo.com.br', 56);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Aberto', '11-7890-0987', 'contato@sorrisoaberto.com.br', 57);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Evolução', '11-8901-1098', 'info@dentalevolucao.com.br', 58);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Sorriso', '11-9012-2109', 'contato@vivasorriso.com.br', 59);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Saúde Dental', '11-0123-3210', 'suporte@saudedental.com.br', 60);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Saudável', '11-2233-3344', 'contato@sorrisosaudavel.com.br', 61);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Pro', '11-3344-4455', 'info@odontopro.com.br', 62);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Moderno', '11-4455-5566', 'contato@sorrisomoderno.com.br', 63);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Prime', '11-5566-6677', 'suporte@dentalprime.com.br', 64);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Total', '11-6677-7788', 'info@sorrisototal.com.br', 65);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Express', '11-7788-8899', 'contato@odontoexpress.com.br', 66);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso e Saúde', '11-8899-9900', 'info@sorrisoesaude.com.br', 67);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Pro', '11-9900-0011', 'contato@dentalpro.com.br', 68);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso 10', '11-0011-1122', 'suporte@sorriso10.com.br', 69);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Vida Sorriso', '11-1122-2233', 'info@vidasorriso.com.br', 70);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Brilhante', '11-2233-3344', 'contato@sorrisobrilhante.com.br', 71);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoPerfeito', '11-3344-4455', 'info@odontoperfeito.com.br', 72);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Cuidado', '11-4455-5566', 'contato@sorrisocuidado.com.br', 73);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Ideal', '11-5566-6677', 'info@sorrisoideal.com.br', 74);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoMais', '11-6677-7788', 'contato@odontomais.com.br', 75);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Viva Sorriso', '11-7788-8899', 'info@vivasorriso.com.br', 76);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Esperança', '11-8899-9900', 'contato@sorrisoesperanca.com.br', 77);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Premium', '11-9900-0011', 'suporte@sorrisopremium.com.br', 78);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Vida e Saúde', '11-0011-1122', 'info@vidaesaude.com.br', 79);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Completo', '11-1122-2233', 'contato@sorrisocompleto.com.br', 80);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Perfeito', '11-2233-4455', 'contato@sorrisoperfeito.com.br', 81);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoPremium', '11-3344-5566', 'info@odontopremium.com.br', 82);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Jovem', '11-4455-6677', 'contato@sorrisojovem.com.br', 83);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoCare', '11-5566-7788', 'info@odontocare.com.br', 84);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Atual', '11-6677-8899', 'suporte@sorrisoatual.com.br', 85);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Sorriso', '11-7788-9900', 'contato@dentalsorriso.com.br', 86);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Total', '11-8899-0011', 'info@odontototal.com.br', 87);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso e Vida', '11-9900-1122', 'suporte@sorrisoevida.com.br', 88);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Completa', '11-0011-2233', 'contato@odontocompleta.com.br', 89);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Total Plus', '11-1122-3344', 'info@sorrisototalplus.com.br', 90);

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Master', '11-2233-4455', 'contato@odontomaster.com.br', 91);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Real', '11-3344-5566', 'info@sorrisoreal.com.br', 92);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto VIP', '11-4455-6677', 'contato@odontovip.com.br', 93);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Certeiro', '11-5566-7788', 'info@sorrisocerteiro.com.br', 94);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Brilho', '11-6677-8899', 'contato@odontobrilho.com.br', 95);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Excelência', '11-7788-9900', 'info@sorrisoexcelencia.com.br', 96);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Odonto Plus', '11-8899-0011', 'suporte@odontoplus.com.br', 97);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Diamante', '11-9900-1122', 'info@sorrisodiamante.com.br', 98);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Dental Infinity', '11-0011-2233', 'contato@dentalinfinity.com.br', 99);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Completo VIP', '11-1122-3344', 'suporte@sorrisocompletovip.com.br', 100);

select * from Clinica;

-- Inserindo dados na tabela ClinicaTurno
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 1); -- Clínica 1, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 2); -- Clínica 1, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 3); -- Clínica 1, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (2, 1); -- Clínica 2, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (2, 2); -- Clínica 2, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (3, 1); -- Clínica 3, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (3, 2); -- Clínica 3, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (4, 1); -- Clínica 4, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (5, 2); -- Clínica 5, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (6, 3); -- Clínica 6, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (7, 1); -- Clínica 6, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (8, 1); -- Clínica 6, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (9, 2); -- Clínica 6, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (10, 2); -- Clínica 6, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (10, 1); -- Clínica 6, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (10, 3); -- Clínica 6, Noite

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (11, 1); -- Clínica 11, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (12, 2); -- Clínica 12, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (12, 3); -- Clínica 12, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (13, 1); -- Clínica 13, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (13, 2); -- Clínica 13, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (14, 3); -- Clínica 14, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (15, 1); -- Clínica 15, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (16, 2); -- Clínica 16, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (17, 1); -- Clínica 17, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (17, 3); -- Clínica 17, Noite

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (18, 2); -- Clínica 18, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (19, 1); -- Clínica 19, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (19, 2); -- Clínica 19, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (19, 3); -- Clínica 19, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (20, 1); -- Clínica 20, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (20, 3); -- Clínica 20, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (21, 2); -- Clínica 21, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (22, 1); -- Clínica 22, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (22, 3); -- Clínica 22, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (23, 1); -- Clínica 23, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (24, 2); -- Clínica 24, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (25, 1); -- Clínica 25, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (25, 2); -- Clínica 25, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (26, 1); -- Clínica 26, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (26, 3); -- Clínica 26, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (27, 2); -- Clínica 27, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (28, 1); -- Clínica 28, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (28, 3); -- Clínica 28, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (29, 2); -- Clínica 29, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (30, 1); -- Clínica 30, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (31, 1); -- Clínica 31, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (31, 2); -- Clínica 31, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (32, 3); -- Clínica 32, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (33, 1); -- Clínica 33, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (33, 3); -- Clínica 33, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (34, 2); -- Clínica 34, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (35, 1); -- Clínica 35, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (35, 2); -- Clínica 35, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (36, 3); -- Clínica 36, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (37, 1); -- Clínica 37, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (38, 2); -- Clínica 38, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (39, 1); -- Clínica 39, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (39, 3); -- Clínica 39, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (40, 2); -- Clínica 40, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (40, 3); -- Clínica 40, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (41, 1); -- Clínica 41, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (41, 2); -- Clínica 41, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (42, 1); -- Clínica 42, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (43, 3); -- Clínica 43, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (44, 2); -- Clínica 44, Tarde

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (45, 1); -- Clínica 45, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (45, 3); -- Clínica 45, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (46, 2); -- Clínica 46, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (47, 1); -- Clínica 47, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (47, 2); -- Clínica 47, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (48, 3); -- Clínica 48, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (49, 1); -- Clínica 49, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (50, 2); -- Clínica 50, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (50, 3); -- Clínica 50, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (51, 1); -- Clínica 51, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (52, 2); -- Clínica 52, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (53, 1); -- Clínica 53, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (53, 2); -- Clínica 53, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (53, 3); -- Clínica 53, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (54, 1); -- Clínica 54, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (54, 3); -- Clínica 54, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (55, 2); -- Clínica 55, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (56, 1); -- Clínica 56, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (56, 3); -- Clínica 56, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (57, 2); -- Clínica 57, Tarde

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (58, 1); -- Clínica 58, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (58, 2); -- Clínica 58, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (59, 3); -- Clínica 59, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (60, 1); -- Clínica 60, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (60, 2); -- Clínica 60, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (61, 1); -- Clínica 61, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (61, 3); -- Clínica 61, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (62, 2); -- Clínica 62, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (63, 1); -- Clínica 63, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (63, 3); -- Clínica 63, Noite

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (64, 2); -- Clínica 64, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (65, 1); -- Clínica 65, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (65, 3); -- Clínica 65, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (66, 2); -- Clínica 66, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (67, 1); -- Clínica 67, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (67, 2); -- Clínica 67, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (68, 3); -- Clínica 68, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (69, 1); -- Clínica 69, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (70, 2); -- Clínica 70, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (70, 3); -- Clínica 70, Noite

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (71, 1); -- Clínica 71, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (72, 2); -- Clínica 72, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (72, 3); -- Clínica 72, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (73, 1); -- Clínica 73, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (73, 2); -- Clínica 73, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (74, 3); -- Clínica 74, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (75, 1); -- Clínica 75, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (75, 2); -- Clínica 75, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (76, 1); -- Clínica 76, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (76, 3); -- Clínica 76, Noite

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (77, 2); -- Clínica 77, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (78, 1); -- Clínica 78, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (79, 3); -- Clínica 79, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (80, 1); -- Clínica 80, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (80, 2); -- Clínica 80, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (81, 3); -- Clínica 81, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (82, 1); -- Clínica 82, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (82, 3); -- Clínica 82, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (83, 2); -- Clínica 83, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (84, 1); -- Clínica 84, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (85, 2); -- Clínica 85, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (86, 3); -- Clínica 86, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (87, 1); -- Clínica 87, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (88, 2); -- Clínica 88, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (89, 1); -- Clínica 89, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (90, 2); -- Clínica 90, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (91, 3); -- Clínica 91, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (92, 1); -- Clínica 92, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (93, 2); -- Clínica 93, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (94, 1); -- Clínica 94, Manhã

INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (95, 2); -- Clínica 95, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (96, 3); -- Clínica 96, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (97, 1); -- Clínica 97, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (98, 2); -- Clínica 98, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (99, 3); -- Clínica 99, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (100, 1); -- Clínica 100, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (100, 3); -- Clínica 100, Noite

select * from ClinicaTurno;

-- Inserindo dados na tabela ClinicaDia
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (1, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (1, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (2, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (2, 3);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (3, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (3, 3);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (4, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (5, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (5, 4);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (6, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 3);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 4);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 5);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 6);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (7, 7);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (8, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (9, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (10, 4);

INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (11, 1); -- Clínica 11, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (11, 2); -- Clínica 11, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (12, 3); -- Clínica 12, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (12, 4); -- Clínica 12, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (13, 1); -- Clínica 13, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (14, 2); -- Clínica 14, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (14, 5); -- Clínica 14, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (15, 1); -- Clínica 15, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (15, 3); -- Clínica 15, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (16, 1); -- Clínica 16, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (16, 4); -- Clínica 16, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (16, 5); -- Clínica 16, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (17, 2); -- Clínica 17, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (17, 3); -- Clínica 17, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (18, 1); -- Clínica 18, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (18, 2); -- Clínica 18, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (19, 4); -- Clínica 19, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (19, 5); -- Clínica 19, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (20, 6); -- Clínica 20, Sábado
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (20, 7); -- Clínica 20, Domingo

INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (21, 1); -- Clínica 21, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (21, 3); -- Clínica 21, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (21, 5); -- Clínica 21, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (22, 2); -- Clínica 22, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (22, 4); -- Clínica 22, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (23, 1); -- Clínica 23, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (23, 2); -- Clínica 23, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (23, 3); -- Clínica 23, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (24, 4); -- Clínica 24, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (24, 6); -- Clínica 24, Sábado
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (25, 3); -- Clínica 25, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (25, 5); -- Clínica 25, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (26, 2); -- Clínica 26, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (26, 3); -- Clínica 26, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (26, 5); -- Clínica 26, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (27, 1); -- Clínica 27, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (27, 4); -- Clínica 27, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (28, 3); -- Clínica 28, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (28, 6); -- Clínica 28, Sábado
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (29, 7); -- Clínica 29, Domingo

INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (30, 1); -- Clínica 30, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (30, 5); -- Clínica 30, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (30, 7); -- Clínica 30, Domingo
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (31, 2); -- Clínica 31, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (31, 4); -- Clínica 31, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (32, 1); -- Clínica 32, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (32, 3); -- Clínica 32, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (32, 5); -- Clínica 32, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (33, 2); -- Clínica 33, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (33, 6); -- Clínica 33, Sábado
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (34, 1); -- Clínica 34, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (34, 4); -- Clínica 34, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (35, 2); -- Clínica 35, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (35, 3); -- Clínica 35, Quarta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (36, 1); -- Clínica 36, Segunda
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (36, 5); -- Clínica 36, Sexta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (37, 4); -- Clínica 37, Quinta
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (37, 6); -- Clínica 37, Sábado
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (38, 2); -- Clínica 38, Terça
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (38, 7); -- Clínica 38, Domingo

-- Inserindo dados na tabela ClinicaHorario

INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (1, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (1, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (2, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (2, 3);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (3, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (3, 4);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (4, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (4, 3);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (5, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (6, 5);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (7, 4);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (8, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (9, 6);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (10, 5);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (10, 1);

SELECT * FROM ClinicaHorario;

-- Inserindo dados na tabela ClinicaEspecialidade

INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (1, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (1, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (2, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (2, 3);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (3, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (3, 4);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (4, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (4, 3);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (5, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (6, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (7, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (8, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (9, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (10, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (5, 2);

SELECT * FROM ClinicaEspecialidade;

-- Inserindo dados na tabela ClinicaEspecialista

INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (1, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (1, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (2, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (2, 3);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (3, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (3, 4);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (4, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (4, 3);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (5, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (6, 5);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (7, 4);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (8, 3);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (9, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (10, 5);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (10, 1);

SELECT * FROM ClinicaEspecialista;

-- Inserir dados iniciais na tabela status_sugestao
INSERT INTO statusSugestao (descricao) VALUES ('Pendente');
INSERT INTO statusSugestao (descricao) VALUES ('Aceito');
INSERT INTO statusSugestao (descricao) VALUES ('Recusado');

-- Inserir dados iniciais na tabela motivoRecusa
INSERT INTO motivoRecusa (descricao) VALUES ('Data não atende');
INSERT INTO motivoRecusa (descricao) VALUES ('Horário não atende');
INSERT INTO motivoRecusa (descricao) VALUES ('Localização distante');
INSERT INTO motivoRecusa (descricao) VALUES ('Especialidade');
INSERT INTO motivoRecusa (descricao) VALUES ('Preço da consulta');
INSERT INTO motivoRecusa (descricao) VALUES ('Mudança de plano de saúde');
INSERT INTO motivoRecusa (descricao) VALUES ('Problemas pessoais');
INSERT INTO motivoRecusa (descricao) VALUES ('Não recebeu confirmação');
INSERT INTO motivoRecusa (descricao) VALUES ('Conflito de agenda');
INSERT INTO motivoRecusa (descricao) VALUES ('Preferência por outro profissional');
INSERT INTO motivoRecusa (descricao) VALUES ('Experiência anterior negativa');
INSERT INTO motivoRecusa (descricao) VALUES ('Não atende às necessidades específicas');
INSERT INTO motivoRecusa (descricao) VALUES ('Não atende o turno, precisa alterar.');

-- Inserir dados iniciais na tabela perfilRecusa
INSERT INTO perfilRecusa (descricao) VALUES ('Cliente');
INSERT INTO perfilRecusa (descricao) VALUES ('Clinica');

-- Inserindo dados na tabela Tratamento

INSERT INTO Tratamento (descricao_tratamento) VALUES ('Limpeza Dental');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Restauração');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Canal');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Extração');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Apicoectomia');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Ortodontia');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Clareamento Dental');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Prótese');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Tratamento de Gengivite');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Reimplante Dentário');

-- Inserir dados iniciais na tabela sugestaoConsulta

select * from sugestaoConsulta;
select * from statusSugestao;
select * from motivoRecusa;
select * from Turno;
select * from Especialista;
select * from preferenciaDia;
select * from preferenciaHorario;
select * from Tratamento;

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'João Silva', 'Segunda-feira', '08:00', 'Manhã', 'Clínica da Saúde', 
'Rua das Flores, 123', 'Dr. Paulo Oliveira', 'Consulta Geral', 150);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 'Maria Souza', 'Quarta-feira', '10:00', 'Manhã', 'Clínica Bem Estar', 
'Avenida Brasil, 456', 'Dra. Ana Costa', 'Consulta Odontológica', 200);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (3, 1, 3, 1, 2, 3, 3, 3, 1, 3, 'Carlos Mendes', 'Sexta-feira', '14:00', 'Tarde', 'Clínica Saúde Total', 
'Rua da Paz, 789', 'Dr. Ricardo Lima', 'Exame de Sangue', 100);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (4, 2, 1, 1, 2, 1, 1, 2, 1, 4, 'Ana Paula', 'Terça-feira', '11:00', 'Manhã', 'Clínica do Coração', 
'Rua da Saúde, 321', 'Dr. Bruno Santos', 'Consulta Cardiológica', 250);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (5, 1, 2, 1, 1, 5, 5, 1, 1, 5, 'Luiz Fernando', 'Quinta-feira', '09:00', 'Manhã', 'Clínica do Bem', 
'Rua do Sol, 654', 'Dra. Fernanda Almeida', 'Consulta Dermatológica', 180);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (6, 3, 3, 1, 2, 6, 6, 2, 1, 6, 'Patrícia Gomes', 'Sábado', '15:00', 'Tarde', 'Clínica Saúde e Vida', 
'Rua dos Lírios, 159', 'Dr. Samuel Costa', 'Consulta Neurológica', 220);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (7, 2, 1, 1, 1, 1, 1, 1, 1, 7, 'Fábio Oliveira', 'Domingo', '16:00', 'Tarde', 'Clínica Saúde em Dia', 
'Rua das Palmeiras, 852', 'Dra. Júlia Mendes', 'Consulta de Rotina', 130);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (8, 3, 2, 1, 2, 2, 2, 3, 1, 8, 'Roberta Lima', 'Segunda-feira', '08:30', 'Manhã', 'Clínica Med Saúde', 
'Rua dos Anjos, 888', 'Dr. Diego Ferreira', 'Consulta Pediátrica', 200);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (9, 1, 1, 1, 1, 3, 3, 2, 1, 9, 'Tiago Martins', 'Quarta-feira', '10:30', 'Manhã', 'Clínica do Coração', 
'Rua do Norte, 101', 'Dra. Silvia Araújo', 'Consulta de Check-up', 160);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (10, 2, 3, 1, 2, 5, 5, 1, 1, 10, 'Bruna Cardoso', 'Sábado', '09:00', 'Manhã', 'Clínica Saúde Feliz', 
'Rua do Bem, 202', 'Dr. Eduardo Nascimento', 'Consulta Ginecológica', 190);

select * from sugestaoConsulta;

-- Inserindo dados na tabela TipoServico

INSERT INTO TipoServico (descricao_tipo_servico) VALUES ('presencial');
INSERT INTO TipoServico (descricao_tipo_servico) VALUES ('remoto');

-- Inserindo dados na tabela Retorno

INSERT INTO Retorno (descricao_retorno) VALUES ('Sim');
INSERT INTO Retorno (descricao_retorno) VALUES ('Não');

-- Inserindo dados na tabela StatusFeedback

INSERT INTO StatusFeedback (descricao_status) VALUES ('Respondido');
INSERT INTO StatusFeedback (descricao_status) VALUES ('Não Respondido');

select * from statusFeedback;

-- Inserts para a Tabela Feedback

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Excelente atendimento!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 4, 'Bom serviço, mas o tempo de espera foi longo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 3, 'Atendimento razoável, poderia ser melhor.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 4, 4, 2, 'Não fiquei satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 5, 5, 1, 'Péssimo serviço, não recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 6, 6, 5, 'Ótimo, super recomendo!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 7, 7, 4, 'Bom atendimento, mas poderia melhorar a comunicação.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 8, 8, 3, 'Regular, atendeu as minhas necessidades.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 9, 9, 5, 'Melhor especialista que já fui, super atencioso!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 10, 10, 2, 'O especialista estava apressado, não gostei muito.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Atendimento horrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Muito tempo de espera e atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Não fui bem atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 1, 'Não recomendo, péssima experiência.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 1, 'Desorganização total.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 1, 'Fui ignorado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 1, 'O atendimento foi muito ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 1, 'Não gostei, total falta de profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 1, 'Não resolveram o meu problema.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 1, 'Atendimento péssimo, demorado e sem qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 1, 'A clínica estava suja.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 1, 1, 'Não voltaria nunca.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 2, 1, 'Completamente insatisfeito com o serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 2, 1, 'Não consegui resolver meu problema com eles.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 2, 1, 'Muito insatisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 3, 1, 'Falta de respeito com o cliente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 3, 1, 'Pior consulta que já tive.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 3, 1, 'Profissional despreparado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 1, 1, 'Atendimento muito aquém do esperado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 1, 1, 'Atendimento razoável.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 1, 'Uma experiência desastrosa.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 1, 2, 'Esperava mais do atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 1, 2, 'Fui atendido, mas com muitos problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 1, 2, 'Não foi um bom atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 2, 2, 'Serviço abaixo do esperado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 2, 2, 'Atendimento razoável, mas com falhas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 3, 2, 2, 'Pouca atenção aos detalhes.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 3, 2, 'Atendimento muito corrido e sem cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 3, 2, 'Demorou muito para ser atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 3, 2, 'O atendimento não foi satisfatório.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Faltou organização e eficiência.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Experiência decepcionante.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Muitos atrasos e pouca atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 2, 'Achei que poderiam ser mais atenciosos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 2, 'Serviço ok, mas com margem para melhora.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 2, 'Faltou profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 2, 'Serviço lento e desorganizado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 2, 'Demoraram muito para me atender.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 2, 'Pouco cuidado e atenção durante a consulta.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 2, 'Faltou atenção ao cliente.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Deixou a desejar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 1, 2, 'Não fiquei satisfeito com o serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 1, 3, 'Atendimento razoável, mas pode melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 1, 3, 'Não foi ruim, mas esperava mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 3, 'O serviço foi mediano.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 2, 3, 'Tudo ocorreu de forma aceitável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 2, 3, 'Nada de especial, atendimento ok.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 2, 3, 'Foi uma experiência regular.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 3, 3, 'Atendimento dentro do esperado.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 3, 3, 'Consulta mediana, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 3, 3, 'O serviço foi ok, sem nada demais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 1, 3, 'Atendimento regular, nada de mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 1, 3, 'Foi tudo bem, mas podia ser melhor.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 1, 3, 'Consulta normal, nada excepcional.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 2, 3, 'Atendimento regular, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 2, 3, 'Foi uma consulta ok, mas poderia melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 2, 3, 'Tudo dentro do esperado, mas nada de especial.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 3, 3, 'Esperava um pouco mais, mas foi razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 3, 3, 'Consulta normal, sem problemas graves.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 4, 'Bom atendimento e profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 1, 4, 'Gostei bastante do atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 2, 4, 'Fui bem atendido e fiquei satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 2, 4, 'Ambiente agradável e atendimento de qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 2, 4, 'Muito bom, com certeza voltarei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 3, 4, 'Experiência bem positiva.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 3, 4, 'Fui bem atendido, consulta eficiente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 1, 4, 'Profissional atencioso, tudo foi ótimo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 1, 4, 'Gostei muito da atenção que recebi.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 1, 4, 'Consulta boa e sem problemas.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 4, 'Atendimento muito satisfatório.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 4, 'Bom atendimento e ambiente limpo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 4, 'Muito bom, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 3, 4, 'Consulta boa e sem complicações.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 3, 4, 'Atendimento bom e rápido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 1, 4, 'Muito satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 1, 4, 'Profissional bem preparado, foi tudo ótimo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 1, 5, 'Atendimento excelente, recomendo!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 1, 5, 'Ótima experiência, fui muito bem atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 1, 5, 'Profissionais muito atenciosos e capacitados.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 5, 'Muito satisfeito com a qualidade do serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 5, 'Atendimento excepcional, vou voltar com certeza.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 5, 'Excelente atendimento, equipe muito qualificada.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 3, 5, 'O serviço foi perfeito, melhor clínica que já fui.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 3, 5, 'Muito satisfeito, atendimento de primeira.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 1, 5, 'Equipe muito atenciosa e tratamento de alta qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 1, 5, 'Tudo impecável, recomendo fortemente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 1, 5, 'Atendimento excelente, fui muito bem recebido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 2, 5, 'Muito satisfeito, atendimento exemplar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 2, 5, 'Ótimo atendimento, nota 10.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 5, 'Serviço de excelência, sem defeitos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 3, 5, 'Excelente atendimento, com certeza recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 5, 'Consulta perfeita, tudo correu muito bem.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 5, 'Ótimo atendimento, muito satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 5, 'Atendimento nota 10, recomendo para todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 1, 5, 'Atendimento excelente, superou minhas expectativas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 1, 3, 'O atendimento foi suficiente, mas sem grandes surpresas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 1, 3, 'Foi razoável, mas poderia ter sido mais atencioso.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 1, 3, 'A consulta foi aceitável, porém com melhorias a fazer.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 2, 3, 'O serviço foi regular, sem muito destaque.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (11, 2, 2, 3, 'Atendimento foi mediano, podia ter mais atenção.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 3, 'Consulta razoável, mas poderia melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 3, 3, 'O atendimento foi ok, mas nada de especial.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 3, 'Consulta normal, atendimento básico.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 3, 'Foi dentro do esperado, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 3, 'A consulta foi ok, mas não houve nada de diferente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 1, 3, 'Fui atendido, mas o serviço foi apenas razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 3, 1, 3, 'Atendimento dentro do padrão, mas sem grandes qualidades.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 2, 3, 'O serviço foi ok, mas não me surpreendeu.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 2, 3, 'Foi um atendimento simples, sem grandes diferenciais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 2, 3, 'Consulta foi regular, mas nada impressionante.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 3, 3, 'Atendimento padrão, nada de novo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 3, 3, 'Fui atendido de maneira adequada, mas sem destaques.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 3, 'Atendimento simples, razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 3, 'Consulta foi ok, mas com alguns pontos a melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Consulta agradável e bom atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 4, 'Foi um bom serviço, estou satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 1, 4, 'Fiquei satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 4, 'O atendimento foi bom, tudo correu bem.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 4, 'Ambiente agradável e ótimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 4, 'Muito satisfeito com o resultado da consulta.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 4, 'Ótima consulta, serviço de qualidade.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Atendimento foi muito bom, gostei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Consulta realizada com sucesso, muito bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 4, 'Atendimento foi muito positivo, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 3, 'Tudo ocorreu conforme o esperado, ótimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 5, 'Profissionais atenciosos, gostei muito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 4, 'Bom atendimento, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 4, 'Consulta agradável, serviço bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 5, 'Gostei bastante do atendimento, foi muito bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 4, 'Fui bem atendido e me senti confortável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 3, 'Atendimento foi bom, tudo tranquilo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Muito bom, serviço de qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 4, 'Profissionais bem preparados, ótimo atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Atendimento perfeito, nada a reclamar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Fui muito bem atendido, excelente equipe.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 5, 'Ótima consulta, profissionais capacitados.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 5, 'Equipe maravilhosa, fui muito bem recebido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 5, 'Atendimento excepcional, superou expectativas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 5, 'Clínica de excelência, adorei o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 5, 'Muito bom, atendimento impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 5, 'Serviço incrível, tudo perfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 5, 'Consulta excelente, recomendaria a todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Fiquei muito satisfeito, foi perfeito.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Profissionais de alto nível, atendimento impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 5, 'Fui extremamente bem tratado, perfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 5, 'Atendimento maravilhoso, melhor impossível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 5, 'Clínica excelente, tudo impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 5, 'Fui tratado com muito cuidado, excelente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 5, 'Serviço excepcional, nota máxima.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 5, 'Consulta excelente, recomendo a todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 5, 'Profissionais altamente qualificados.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Experiência incrível, sem falhas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Atendimento perfeito, super recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Atendimento péssimo, não recomendo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Consulta horrível, muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Não gostei, atendimento terrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 1, 'Muito ruim, falta de profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 1, 'Total falta de atenção, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 1, 'Fui muito mal atendido, péssimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 1, 'Atendimento desastroso, não recomendo a ninguém.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 1, 'Consulta completamente insatisfatória.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 1, 'Horrível, a pior consulta que já fiz.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Foi péssimo, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Experiência horrível, fiquei muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Atendimento abaixo de qualquer expectativa, péssimo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 1, 'Serviço terrível, total falta de atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 1, 'Péssimo atendimento, saí muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 1, 'Não fui bem tratado, atendimento horrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 1, 'Consulta ruim, péssimo ambiente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 1, 'Horrível, não recomendo para ninguém.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 1, 'Experiência péssima, fiquei muito decepcionado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Total falta de respeito com o paciente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Atendimento horrível, jamais voltarei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Atendimento fraco, faltou cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Consulta deixou muito a desejar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Não foi uma boa experiência, bastante ruim.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 2, 'Atendimento fraco, esperava mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 2, 'O serviço foi ruim, faltou atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 2, 'Consulta abaixo do esperado, atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 2, 'Serviço ruim, não fiquei satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 2, 'Foi um atendimento ruim, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 2, 'Faltou atenção e cuidado, atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Consulta ruim, esperava mais cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Atendimento muito fraco, fiquei decepcionado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Serviço ruim, não volto mais a essa clínica.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 2, 'Consulta fraca, faltou atenção do dentista.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 2, 'Experiência ruim, muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 2, 'Não foi bom, faltou mais cuidado no atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 2, 'Consulta decepcionante, serviço ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 2, 'O atendimento foi fraco, fiquei insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 2, 'Não gostei da consulta, serviço ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 1, 2, 'Foi um atendimento ruim, faltou atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 1, 2, 'Consulta ruim, esperava mais cuidado.');

-- Inserindo dados na tabela Consulta

INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (1, 1, 1, 1, 'presencial', TO_TIMESTAMP('2024-10-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Limpeza', 100.00, 1, TO_DATE('2024-11-21', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (2, 2, 2, 2, 'remoto', TO_TIMESTAMP('2024-10-22 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Avaliação', 80.00, 1, TO_DATE('2024-11-22', 'YYYY-MM-DD'), 1, 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback) VALUES (3, 3, 3, 3, 'presencial', TO_TIMESTAMP('2024-10-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Consulta Geral', 150.00, 2, TO_DATE('2024-11-23', 'YYYY-MM-DD'), 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback) VALUES (4, 4, 4, 4, 'remoto', TO_TIMESTAMP('2024-10-24 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tratamento', 200.00, 2, TO_DATE('2024-11-24', 'YYYY-MM-DD'), 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (5, 5, 5, 5, 'presencial', TO_TIMESTAMP('2024-10-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Exame', 120.00, 1, TO_DATE('2024-11-25', 'YYYY-MM-DD'), 1, 5);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (6, 6, 6, 6, 'remoto', TO_TIMESTAMP('2024-10-26 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Acompanhamento', 90.00, 1, TO_DATE('2024-11-26', 'YYYY-MM-DD'), 1, 6);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback) VALUES (7, 7, 7, 7, 'presencial', TO_TIMESTAMP('2024-10-27 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Limpeza', 100.00, 2, TO_DATE('2024-11-27', 'YYYY-MM-DD'), 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback) VALUES (8, 8, 8, 8, 'remoto', TO_TIMESTAMP('2024-10-28 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Avaliação', 80.00, 2, TO_DATE('2024-11-28', 'YYYY-MM-DD'), 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (9, 9, 9, 9, 'presencial', TO_TIMESTAMP('2024-10-29 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Consulta Geral', 150.00, 1, TO_DATE('2024-11-29', 'YYYY-MM-DD'), 1, 9);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (10, 10, 10, 10, 'remoto', TO_TIMESTAMP('2024-10-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tratamento', 200.00, 1, TO_DATE('2024-11-30', 'YYYY-MM-DD'), 1, 10);

select * from Consulta;

commit;