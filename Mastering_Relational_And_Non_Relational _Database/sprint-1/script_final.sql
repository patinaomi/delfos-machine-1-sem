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

// Inserts Cliente

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Alice', 'Silva', 'alice.silva@example.com', '11987654321', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'Rua das Flores, 123');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Bruno', 'Santos', 'bruno.santos@example.com', '11976543210', TO_DATE('1985-03-20', 'YYYY-MM-DD'), 'Avenida Central, 456');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Carlos', 'Oliveira', 'carlos.oliveira@example.com', '11965432109', TO_DATE('1992-07-11', 'YYYY-MM-DD'), 'Rua dos Lírios, 789');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Diana', 'Pereira', 'diana.pereira@example.com', '11954321098', TO_DATE('1988-04-22', 'YYYY-MM-DD'), 'Praça das Árvores, 321');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Eduardo', 'Melo', 'eduardo.melo@example.com', '11943210987', TO_DATE('1980-09-05', 'YYYY-MM-DD'), 'Avenida do Sol, 654');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Fernanda', 'Costa', 'fernanda.costa@example.com', '11932109876', TO_DATE('1995-12-30', 'YYYY-MM-DD'), 'Rua das Estrelas, 852');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Gabriel', 'Santos', 'gabriel.santos@example.com', '11921098765', TO_DATE('1991-11-19', 'YYYY-MM-DD'), 'Rua das Palmeiras, 963');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Helena', 'Lima', 'helena.lima@example.com', '11910987654', TO_DATE('1989-06-15', 'YYYY-MM-DD'), 'Avenida das Rosas, 147');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Igor', 'Barros', 'igor.barros@example.com', '11898765432', TO_DATE('1994-03-29', 'YYYY-MM-DD'), 'Rua das Acácias, 258');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Juliana', 'Martins', 'juliana.martins@example.com', '11787654321', TO_DATE('1993-08-10', 'YYYY-MM-DD'), 'Avenida da Paz, 369');

select * from Cliente;

// Clinica

INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica Saúde e Sorriso', 'Rua das Flores, 123', '11987654321', 4.5, 150.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica Odontológica São José', 'Avenida Central, 456', '11976543210', 4.0, 200.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica Dental Plus', 'Rua da Esperança, 789', '11965432109', 5.0, 250.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('OdontoCare', 'Avenida Brasil, 321', '11954321098', 3.8, 180.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica do Sorriso', 'Rua das Acácias, 654', '11943210987', 4.2, 170.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica OdontoMax', 'Praça da Saúde, 135', '11932109876', 4.7, 220.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Centro Dental', 'Alameda dos Anjos, 246', '11921098765', 4.1, 160.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica Vida e Sorriso', 'Rua do Progresso, 357', '11910987654', 4.6, 190.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Consultório Odontológico Esperança', 'Beco do Sorriso, 888', '11909876543', 3.9, 175.00);
INSERT INTO Clinica (nome, endereco, telefone, avaliacao, preco_medio) VALUES ('Clínica Nova Esperança', 'Rua do Futuro, 101', '11998765432', 4.8, 210.00);

select * from clinica;

// Especialidade

INSERT INTO Especialidade (nome) VALUES ('Ortodontia');
INSERT INTO Especialidade (nome) VALUES ('Implantodontia');
INSERT INTO Especialidade (nome) VALUES ('Odontopediatria');
INSERT INTO Especialidade (nome) VALUES ('Periodontia');
INSERT INTO Especialidade (nome) VALUES ('Endodontia');
INSERT INTO Especialidade (nome) VALUES ('Odontologia Estética');
INSERT INTO Especialidade (nome) VALUES ('Cirurgia Bucomaxilofacial');
INSERT INTO Especialidade (nome) VALUES ('Prótese Dentária');
INSERT INTO Especialidade (nome) VALUES ('Dentística');
INSERT INTO Especialidade (nome) VALUES ('Higiene Dental');

select * from especialidade;

// Dentista

INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Carlos', 'Menezes', '11987654321', 1, 1, 4.5);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Fernanda', 'Pereira', '11976543210', 1, 2, 5.0);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Roberto', 'Almeida', '11965432109', 2, 3, 4.0);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Mariana', 'Souza', '11954321098', 2, 4, 4.7);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('André', 'Lima', '11943210987', 1, 5, 3.5);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Juliana', 'Silva', '11932109876', 3, 6, 4.8);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Ricardo', 'Santos', '11921098765', 3, 7, 4.2);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Aline', 'Costa', '11910987654', 1, 8, 4.6);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Felipe', 'Martins', '11909876543', 2, 9, 3.9);
INSERT INTO Dentista (nome, sobrenome, telefone, id_clinica, id_especialidade, avaliacao) VALUES ('Tatiane', 'Ferreira', '11998765432', 3, 10, 5.0);

select * from dentista;

// Consulta

INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (1, 1, 1, 'Check-up', TO_TIMESTAMP('2024-10-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Consulta de rotina', 'Nenhum', 'Manter higiene bucal', 150.00, 'Fluoretação', TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (2, 1, 1, 'Limpeza', TO_TIMESTAMP('2024-10-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Limpeza dental regular', 'Acúmulo de tártaro', 'Limpeza profunda', 200.00, 'Nenhum', TO_DATE('2024-10-16', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (3, 2, 2, 'Consulta de emergência', TO_TIMESTAMP('2024-10-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Dor de dente', 'Dor intensa', 'Tratamento de canal', 500.00, 'Analgésicos', TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (4, 2, 2, 'Check-up', TO_TIMESTAMP('2024-10-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Consulta de rotina', 'Sem queixas', 'Manter cuidados', 150.00, 'Fluoretação', TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (5, 3, 3, 'Limpeza', TO_TIMESTAMP('2024-10-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'N', 'Limpeza programada', 'Alguma dor', 'Limpeza e acompanhamento', 220.00, 'Analgésicos', TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (6, 3, 3, 'Consulta de emergência', TO_TIMESTAMP('2024-10-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Dor na gengiva', 'Dor constante', 'Antibióticos', 300.00, 'Antibióticos', TO_DATE('2024-10-23', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (7, 1, 1, 'Check-up', TO_TIMESTAMP('2024-10-07 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Consulta de rotina', 'Nenhum', 'Manter higiene bucal', 150.00, 'Fluoretação', TO_DATE('2024-10-24', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (8, 1, 1, 'Limpeza', TO_TIMESTAMP('2024-10-08 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'N', 'Limpeza agendada', 'Acúmulo de tártaro', 'Limpeza profunda', 200.00, 'Nenhum', TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (9, 2, 2, 'Consulta de emergência', TO_TIMESTAMP('2024-10-09 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Dor de dente', 'Dor intensa', 'Tratamento de canal', 500.00, 'Analgésicos', TO_DATE('2024-10-30', 'YYYY-MM-DD'));
INSERT INTO Consulta (id_cliente, id_clinica, id_dentista, tipo_servico, data_consulta, status_consulta, observacoes, sintomas, tratamento_recomendado, custo, prescricao, data_retorno) VALUES (10, 3, 3, 'Check-up', TO_TIMESTAMP('2024-10-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S', 'Consulta de rotina', 'Sem queixas', 'Manter cuidados', 150.00, 'Fluoretação', TO_DATE('2024-10-31', 'YYYY-MM-DD'));

select * from consulta;

// Sinistro

INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (1, 'Sinistro 1', 'Quebra de dente durante a consulta', 'S', 'Aguardando documentação', 1000.00, TO_DATE('2024-10-01', 'YYYY-MM-DD'), NULL, 'documento1.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (2, 'Sinistro 2', 'Reação alérgica após tratamento', 'S', 'Em análise', 800.00, TO_DATE('2024-10-02', 'YYYY-MM-DD'), NULL, 'documento2.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (3, 'Sinistro 3', 'Dor intensa após procedimento', 'N', 'Resolvido', 500.00, TO_DATE('2024-10-03', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'documento3.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (4, 'Sinistro 4', 'Infeção após extração', 'S', 'Aguardando avaliação', 1200.00, TO_DATE('2024-10-04', 'YYYY-MM-DD'), NULL, 'documento4.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (5, 'Sinistro 5', 'Lesão na gengiva', 'S', 'Aguardando resposta do dentista', 300.00, TO_DATE('2024-10-05', 'YYYY-MM-DD'), NULL, 'documento5.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (6, 'Sinistro 6', 'Complicação com anestesia', 'N', 'Resolvido', 600.00, TO_DATE('2024-10-06', 'YYYY-MM-DD'), TO_DATE('2024-10-11', 'YYYY-MM-DD'), 'documento6.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (7, 'Sinistro 7', 'Queixa de dor persistente', 'S', 'Em avaliação', 400.00, TO_DATE('2024-10-07', 'YYYY-MM-DD'), NULL, 'documento7.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (8, 'Sinistro 8', 'Tratamento de canal falhou', 'S', 'Aguardando revisão', 900.00, TO_DATE('2024-10-08', 'YYYY-MM-DD'), NULL, 'documento8.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (9, 'Sinistro 9', 'Problema na prótese', 'N', 'Resolvido', 700.00, TO_DATE('2024-10-09', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'documento9.pdf');
INSERT INTO Sinistro (id_consulta, nome, descricao, status_sinistro, descricao_status, valor_sinistro, data_abertura, data_resolucao, documentacao) VALUES (10, 'Sinistro 10', 'Queixa de mau hálito persistente', 'S', 'Aguardando consulta adicional', 200.00, TO_DATE('2024-10-10', 'YYYY-MM-DD'), NULL, 'documento10.pdf');

// Feedback

INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (1, 1, 1, 5.0, 'Ótimo atendimento!');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (2, 1, 1, 4.0, 'A consulta foi muito boa.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (3, 2, 2, 5.0, 'Profissional atencioso e cuidadoso.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (4, 2, 2, 4.0, 'Ambiente agradável.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (5, 3, 3, 3.0, 'Esperava mais, mas foi tudo bem.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (6, 3, 3, 4.0, 'Consulta rápida e eficaz.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (7, 1, 1, 5.0, 'Recomendo para todos!');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (8, 2, 2, 4.0, 'Foi uma experiência positiva.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (9, 1, 1, 3.0, 'Um pouco de espera, mas no geral bom.');
INSERT INTO Feedback (id_cliente, id_dentista, id_clinica, avaliacao, comentario) VALUES (10, 3, 3, 5.0, 'Atendimento de qualidade.');

// Estado Civil

INSERT INTO Estado_Civil (descricao) VALUES ('Solteiro');
INSERT INTO Estado_Civil (descricao) VALUES ('Casado');
INSERT INTO Estado_Civil (descricao) VALUES ('Divorciado');
INSERT INTO Estado_Civil (descricao) VALUES ('Viúvo');
INSERT INTO Estado_Civil (descricao) VALUES ('União Estável');
INSERT INTO Estado_Civil (descricao) VALUES ('Separado');
INSERT INTO Estado_Civil (descricao) VALUES ('Companheiro');
INSERT INTO Estado_Civil (descricao) VALUES ('Desquitado');
INSERT INTO Estado_Civil (descricao) VALUES ('Noivo');
INSERT INTO Estado_Civil (descricao) VALUES ('Namorando');

// Formulario Detalhado

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(1, 1, 'Nenhum histórico significativo', 'Engenheiro', 5000.00, 'Saudável', 'Nenhuma', 'Hipertensão', 'Apenas paracetamol', 'Não', 'Y', 'Mãe', 'Y', SYSDATE, 'Y', 'Nenhuma', 'Viagens internacionais', 'Mudanças a cada 2 anos', 'Email');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(2, 2, 'Apenas histórico de diabetes na família', 'Médico', 7000.00, 'Saudável', 'Nenhuma', 'Asma', 'Nenhum', 'Sim', 'Y', 'Pai', 'Y', SYSDATE, 'Y', 'Risco baixo', 'Viagens a trabalho', 'Mudança recente', 'Telefone');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(3, 3, 'Histórico de problemas cardíacos', 'Professor', 4000.00, 'Diabetes', 'Alergia a pó', 'Diabetes tipo 2', 'Insulina', 'Sim', 'N', 'Irmã', 'Y', SYSDATE, 'N', 'Risco moderado', 'Sem viagens', 'Mudanças frequentes', 'WhatsApp');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(4, 4, 'Nenhum histórico familiar relevante', 'Advogado', 6000.00, 'Saudável', 'Alergia a amendoim', 'Nenhuma', 'Nenhum', 'Não', 'Y', 'Esposa', 'Y', SYSDATE, 'Y', 'Risco baixo', 'Viagens de férias', 'Mudança a cada 5 anos', 'Email');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(5, 5, 'Histórico de câncer na família', 'Arquiteto', 5500.00, 'Saudável', 'Alergia a poeira', 'Nenhuma', 'Nenhum', 'Sim', 'Y', 'Filho', 'N', SYSDATE, 'Y', 'Risco alto', 'Viagens frequentes', 'Mudança há 1 ano', 'Telefone');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(6, 6, 'Nenhum histórico significativo', 'Dentista', 7500.00, 'Saudável', 'Alergia a medicamentos', 'Nenhuma', 'Nenhum', 'Não', 'Y', 'Amigo', 'Y', SYSDATE, 'N', 'Risco baixo', 'Viagens a trabalho', 'Mudança a cada 3 anos', 'WhatsApp');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(7, 7, 'Histórico de doenças respiratórias', 'Cientista', 4500.00, 'Saudável', 'Alergia a fumaça', 'Nenhuma', 'Nenhum', 'Sim', 'N', 'Cônjuge', 'Y', SYSDATE, 'Y', 'Risco moderado', 'Sem viagens', 'Mudanças frequentes', 'Email');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(8, 8, 'Nenhum histórico familiar relevante', 'Motorista', 3000.00, 'Saudável', 'Alergia a látex', 'Nenhuma', 'Nenhum', 'Não', 'Y', 'Irmão', 'Y', SYSDATE, 'N', 'Risco baixo', 'Viagens ocasionais', 'Mudança a cada 4 anos', 'Telefone');

INSERT INTO Formulario_Detalhado (id_cliente, id_estado_civil, historico_familiar, profissao, renda_mensal, historico_medico, alergia, condicao_preexistente, uso_medicamento, familiar_com_doencas_dentarias, participacao_em_programas_preventivos, contato_emergencial, pesquisa_satisfacao, data_ultima_atualizacao, frequencia_consulta_periodica, sinalizacao_de_risco, historico_de_viagem, historico_de_mudancas_de_endereco, preferencia_de_contato) VALUES 
(9, 9, 'Histórico de hipertensão', 'Estudante', 2000.00, 'Saudável', 'Nenhuma', 'Hipertensão', 'Apenas anti-hipertensivos', 'Sim', 'Y', 'Mãe', 'Y', SYSDATE, 'N', 'Risco baixo', 'Viagens de estudos', 'Mudança a cada 2 anos', 'Email');

// Tipo de notificação

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Lembrete de Consulta');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Notificação de Pagamento');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Confirmação de Agendamento');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Cancelamento de Consulta');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Promoção de Serviços');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Atualização de Cadastro');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Aviso de Documentação');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Encaminhamento Médico');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Pesquisa de Satisfação');

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Alerta de Saúde Preventiva');

// Agenda

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (1, 1, 'S', 'Consulta realizada com sucesso.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (2, 2, 'N', 'Consulta cancelada pelo cliente.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (3, 3, 'S', 'Consulta ocorreu conforme planejado.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (4, 4, 'S', 'Cliente compareceu na hora marcada.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (5, 5, 'N', 'Consulta reagendada para a próxima semana.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (6, 6, 'S', 'Procedimento realizado com sucesso.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (7, 7, 'N', 'Consulta não foi confirmada.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (8, 8, 'S', 'Cliente satisfeito com o atendimento.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (9, 9, 'N', 'Consulta não foi realizada.');

INSERT INTO Agenda (id_cliente, id_consulta, status_consulta, observacoes) 
VALUES (10, 10, 'S', 'Consulta finalizada e cliente orientado.');

// Notificação

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (1, 1, 'Sua consulta está agendada para amanhã.', TO_DATE('2024-10-01', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (2, 2, 'Lembrete: é hora de realizar seu check-up anual.', TO_DATE('2024-09-25', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (3, 1, 'Consulta confirmada para a próxima segunda-feira.', TO_DATE('2024-09-28', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (4, 3, 'Obrigado pelo feedback! Aguardamos sua próxima visita.', TO_DATE('2024-09-30', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (5, 1, 'Sua consulta foi reagendada para a próxima sexta-feira.', TO_DATE('2024-10-03', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (6, 2, 'Faltam 7 dias para seu próximo exame preventivo.', TO_DATE('2024-10-04', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (7, 1, 'Aviso: consulta pendente de confirmação.', TO_DATE('2024-09-27', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (8, 3, 'Estamos prontos para recebê-lo em sua próxima consulta.', TO_DATE('2024-09-29', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (9, 2, 'Não se esqueça de manter suas consultas em dia.', TO_DATE('2024-09-26', 'YYYY-MM-DD'));

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, mensagem, data_envio) 
VALUES (10, 1, 'Sua consulta foi confirmada para amanhã às 10h.', TO_DATE('2024-09-30', 'YYYY-MM-DD'));


// Bloco anonimo

// Funções para Atualizar

// 1. Atualizar Telefone do Cliente

DECLARE
    v_id_cliente NUMBER := 2;
    v_novo_telefone VARCHAR2(15) := '999888777';
BEGIN
    UPDATE CLIENTE
    SET Telefone = v_novo_telefone
    WHERE ID_Cliente = v_id_cliente;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Telefone atualizado com sucesso para o cliente ID ' || v_id_cliente);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente encontrado com o ID ' || v_id_cliente);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar: ' || SQLERRM);
        ROLLBACK;
END;

// 2. Atualizar Avaliação da Clínica

DECLARE
    v_id_clinica NUMBER := 1;
    v_nova_avaliacao DECIMAL(2, 1) := 4.5;
BEGIN
    UPDATE CLINICA
    SET avaliacao = v_nova_avaliacao
    WHERE ID_Clinica = v_id_clinica;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Avaliação atualizada com sucesso para a clínica ID ' || v_id_clinica);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhuma clínica encontrada com o ID ' || v_id_clinica);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar: ' || SQLERRM);
        ROLLBACK;
END;

// 3. Atualizar Preço Médio da Clínica

DECLARE
    v_id_clinica NUMBER := 2;
    v_novo_preco DECIMAL(10, 2) := 200.00;
BEGIN
    UPDATE CLINICA
    SET preco_medio = v_novo_preco
    WHERE ID_Clinica = v_id_clinica;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Preço médio atualizado com sucesso para a clínica ID ' || v_id_clinica);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhuma clínica encontrada com o ID ' || v_id_clinica);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar: ' || SQLERRM);
        ROLLBACK;
END;

// Funções para Excluir:

-- 1. Excluir Consulta:

DECLARE
    v_id_consulta NUMBER := 2;
BEGIN
    DELETE FROM CONSULTA
    WHERE ID_Consulta = v_id_consulta;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Consulta excluída com sucesso, ID ' || v_id_consulta);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhuma consulta encontrada com o ID ' || v_id_consulta);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir: ' || SQLERRM);
        ROLLBACK;
END;

-- 2. Excluir Notificação

DECLARE
    v_id_notificacao NUMBER := 3;
BEGIN
    DELETE FROM NOTIFICACAO
    WHERE ID_Notificacao = v_id_notificacao;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Notificação excluída com sucesso, ID ' || v_id_notificacao);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhuma notificação encontrada com o ID ' || v_id_notificacao);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir: ' || SQLERRM);
        ROLLBACK;
END;

-- 3. Excluir sinistro

DECLARE
    v_id_sinistro NUMBER := 1;
BEGIN
    DELETE FROM SINISTRO
    WHERE ID_Sinistro = v_id_sinistro;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Sinistro excluído com sucesso, ID ' || v_id_sinistro);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum sinistro encontrado com o ID ' || v_id_sinistro);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir: ' || SQLERRM);
        ROLLBACK;
END;

select * from sinistro;

// Consulta com INNER JOIN 

-- Cliente e Agenda 
-- Esta consulta exibe o nome dos clientes e o total de consultas agendadas.

DECLARE
    CURSOR c IS
        SELECT cl.Nome, COUNT(a.ID_Agenda) AS Total_Agendas
        FROM CLIENTE cl
        INNER JOIN AGENDA a ON cl.ID_Cliente = a.ID_Cliente
        GROUP BY cl.Nome
        ORDER BY Total_Agendas DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Agendas: ' || x.Total_Agendas);
    END LOOP;
END;

// Consulta com LEFT JOIN
-- Cliente e Notificação
-- Esta consulta exibe o nome dos clientes e o total de notificações recebidas, incluindo clientes que ainda não receberam notificações (o valor será 0).

DECLARE
    CURSOR c IS
        SELECT cl.Nome, COUNT(n.ID_Notificacao) AS Total_Notificacoes
        FROM CLIENTE cl
        LEFT JOIN NOTIFICACAO n ON cl.ID_Cliente = n.ID_Cliente
        GROUP BY cl.Nome
        ORDER BY Total_Notificacoes ASC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Notificações: ' || NVL(x.Total_Notificacoes, 0));
    END LOOP;
END;

// Consulta com RIGHT JOIN
-- Cliente e Feedback

DECLARE
    CURSOR c IS
        SELECT NVL(c.Nome, 'Cliente Desconhecido') AS Nome_Cliente, 
               COUNT(f.ID_Feedback) AS Total_Feedback
        FROM FEEDBACK f
        RIGHT JOIN CLIENTE c ON f.ID_Cliente = c.ID_Cliente
        GROUP BY c.Nome
        ORDER BY Total_Feedback DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome_Cliente || ', Total de Feedbacks: ' || x.Total_Feedback);
    END LOOP;
END;
