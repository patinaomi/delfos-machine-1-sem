-- ESSAS TABELAS NAO SERAO USADAS PARA DATABASE MAS SIM PARA .NET


-- Deletar tabelas caso já existam
DROP TABLE T_Rotina_Cuidado CASCADE CONSTRAINTS;
DROP TABLE T_Estado CASCADE CONSTRAINTS;
DROP TABLE T_Dia_Semana CASCADE CONSTRAINTS;
DROP TABLE T_Login CASCADE CONSTRAINTS;
DROP TABLE T_Usuario CASCADE CONSTRAINTS;
DROP TABLE T_Preferencia_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Turno_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Tipo_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Perfil CASCADE CONSTRAINTS;
DROP TABLE T_Genero CASCADE CONSTRAINTS;
DROP TABLE T_Consulta_Sugerida CASCADE CONSTRAINTS;
DROP TABLE T_Recompensa CASCADE CONSTRAINTS;
DROP TABLE T_Agendamento CASCADE CONSTRAINTS;
DROP TABLE T_Status CASCADE CONSTRAINTS;
DROP TABLE T_Notificacao CASCADE CONSTRAINTS;
DROP TABLE T_Consulta CASCADE CONSTRAINTS;
DROP TABLE T_Tarefa CASCADE CONSTRAINTS;
DROP TABLE T_Programa_Beneficio CASCADE CONSTRAINTS;
DROP TABLE T_Tipo_Notificacao CASCADE CONSTRAINTS;
DROP TABLE T_Reagendamento CASCADE CONSTRAINTS;
DROP TABLE T_Recusa CASCADE CONSTRAINTS;
DROP TABLE T_Cancelamento CASCADE CONSTRAINTS;
DROP TABLE T_Historico_Avaliacao CASCADE CONSTRAINTS;
DROP TABLE T_Pesquisa CASCADE CONSTRAINTS;
DROP TABLE T_Cliente CASCADE CONSTRAINTS;
DROP TABLE T_Clinica CASCADE CONSTRAINTS;
DROP TABLE T_Medico CASCADE CONSTRAINTS;
DROP TABLE T_Especialidade CASCADE CONSTRAINTS;
DROP TABLE T_Endereco_Preferencia CASCADE CONSTRAINTS;
DROP TABLE T_Endereco CASCADE CONSTRAINTS;

-- Criação das tabelas

-- 1. Tabela de Gênero
CREATE TABLE T_Genero (
    id_gen INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_gen VARCHAR2(50) NOT NULL  -- Descrição do gênero
);

-- 2. Tabela de Estado
CREATE TABLE T_Estado (
    id_est INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sigla_est VARCHAR2(2) NOT NULL  -- Sigla do estado
);

-- 3. Tabela de Dia da Semana
CREATE TABLE T_Dia_Semana (
    id_dia_semana INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_dia_semana VARCHAR2(50) NOT NULL  -- Dia da semana (ex: Segunda-feira)
);

-- 4. Tabela de Turno de Atendimento
CREATE TABLE T_Turno_Atendimento (
    id_turno_atend INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_turno_atend VARCHAR2(50) NOT NULL  -- Manhã, tarde, noite
);

-- 5. Tabela de Tipo de Atendimento
CREATE TABLE T_Tipo_Atendimento (
    id_tipo_atendimento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    desc_tipo_atendimento VARCHAR2(50) NOT NULL  -- Presencial, remoto
);

-- 6. Tabela de Sistema de Recompensas
CREATE TABLE T_Recompensa (
    id_recompensa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    pts_acumulados INTEGER NOT NULL,                                -- Pontos acumulados pelo usuário
    desc_recompensa VARCHAR2(255) NOT NULL,                         -- Descrição da recompensa (ex: desconto, brinde)
    data_atualizacao TIMESTAMP NOT NULL                             -- Data da última atualização dos pontos
);

-- 7. Tabela de Preferência de Atendimento
CREATE TABLE T_Preferencia_Atendimento (
    id_pref_atend INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    id_dia_semana_fk INTEGER,                                       -- Referência ao dia da semana preferido
    id_turno_atend_fk INTEGER,                                      -- Referência ao turno de atendimento preferido
    id_tipo_atend_fk INTEGER,                                       -- Referência ao tipo de atendimento preferido
    CONSTRAINT fk_turno_atendimento_pref FOREIGN KEY (id_turno_atend_fk) REFERENCES T_Turno_Atendimento(id_turno_atend),
    CONSTRAINT fk_tipo_atendimento_pref FOREIGN KEY (id_tipo_atend_fk) REFERENCES T_Tipo_Atendimento(id_tipo_atendimento),
    CONSTRAINT fk_dia_semana_atendimento_pref FOREIGN KEY (id_dia_semana_fk) REFERENCES T_Dia_Semana(id_dia_semana)
);

-- 8. Tabela de Endereço Preferência
CREATE TABLE T_Endereco_Preferencia (
    id_end_pref INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_cadastro TIMESTAMP NOT NULL,                                -- Data de cadastro do endereço
    data_atualizacao TIMESTAMP,                                      -- Data da última atualização do endereço
    cep VARCHAR2(10) NOT NULL,                                       -- CEP do endereço
    numero VARCHAR2(10) NOT NULL,                                    -- Número do endereço
    rua VARCHAR2(255) NOT NULL,                                      -- Nome da rua
    bairro VARCHAR2(100) NOT NULL,                                   -- Bairro
    complemento VARCHAR2(255),                                       -- Complemento do endereço
    cidade VARCHAR2(100) NOT NULL,                                   -- Cidade do endereço
    id_estado_fk INTEGER NOT NULL,                                   -- Referência ao estado do endereço
    CONSTRAINT fk_estado_preferencia_endereco FOREIGN KEY (id_estado_fk) REFERENCES T_Estado(id_est)
);

-- 9. Tabela de Endereço
CREATE TABLE T_Endereco (
    id_end INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_cadastro TIMESTAMP NOT NULL,                                -- Data de cadastro do endereço
    data_atualizacao TIMESTAMP,                                      -- Data da última atualização do endereço
    cep VARCHAR2(10) NOT NULL,                                       -- CEP do endereço
    numero VARCHAR2(10) NOT NULL,                                    -- Número do endereço
    rua VARCHAR2(255) NOT NULL,                                      -- Nome da rua
    bairro VARCHAR2(100) NOT NULL,                                   -- Bairro
    complemento VARCHAR2(255),                                       -- Complemento do endereço
    cidade VARCHAR2(100) NOT NULL,                                   -- Cidade do endereço
    id_estado_fk INTEGER NOT NULL,                                   -- Referência ao estado do endereço
    CONSTRAINT fk_estado_endereco FOREIGN KEY (id_estado_fk) REFERENCES T_Estado(id_est)
);

-- 10. Tabela de Usuário
CREATE TABLE T_Usuario (
    id_usuario INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,     
    login_usuario VARCHAR2(100) NOT NULL UNIQUE,                     -- Nome de login do usuário
    senha_usuario VARCHAR2(255) NOT NULL                             -- Senha do usuário
);

-- 11. Tabela de Cliente
CREATE TABLE T_Cliente (
    id_clie INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,       
    nome VARCHAR2(100) NOT NULL,                                     -- Nome do cliente
    sobrenome VARCHAR2(100) NOT NULL,                                -- Sobrenome do cliente
    email VARCHAR2(100) UNIQUE NOT NULL,                             -- Email do cliente
    telefone VARCHAR2(15) NOT NULL,                                  -- Telefone de contato
    cpf VARCHAR2(20) NOT NULL UNIQUE,                                -- CPF do cliente
    data_nascimento DATE NOT NULL,                                   -- Data de nascimento do cliente
    data_criacao TIMESTAMP NOT NULL,                                 -- Data de criação do registro do cliente
    data_atualizacao TIMESTAMP,                                      -- Data da última atualização do registro
    id_endereco_fk INTEGER NOT NULL,                                 -- Referência ao endereço do cliente
    id_genero_fk INTEGER NOT NULL,                                   -- Referência ao gênero do cliente
    id_recompensa_fk INTEGER NOT NULL,                               -- Referência ao sistema de recompensas do cliente
    id_end_preferencia_fk INTEGER NOT NULL,                          -- Referência à preferência de atendimento do cliente
    id_usuario_fk INTEGER NOT NULL,                                  -- Referência ao usuário do cliente
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_endereco_fk) REFERENCES T_Endereco(id_end),
    CONSTRAINT fk_endereco_pref_cliente FOREIGN KEY (id_end_preferencia_fk) REFERENCES T_Endereco_Preferencia(id_end_pref),
    CONSTRAINT fk_genero_cliente FOREIGN KEY (id_genero_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_recompensa_cliente FOREIGN KEY (id_recompensa_fk) REFERENCES T_Recompensa(id_recompensa),
    CONSTRAINT fk_pref_atendimento_cliente FOREIGN KEY (id_end_preferencia_fk) REFERENCES T_Preferencia_Atendimento(id_pref_atend),
    CONSTRAINT fk_usuario_cliente FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_usuario)
);

-- 11. Tabela de Especialidade
CREATE TABLE T_Especialidade (
    id_esp INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_esp VARCHAR2(100) NOT NULL                            -- Descrição da especialidade
);

-- 12. Tabela de Clínica
CREATE TABLE T_Clinica (
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,                                 -- Nome da clínica
    telefone VARCHAR2(35) NOT NULL,                              -- Telefone da clínica
    cnpj VARCHAR2(20) NOT NULL,                                  -- CNPJ da clínica
    data_criacao TIMESTAMP NOT NULL,                             -- Data de criação do registro da clínica
    data_atualizacao TIMESTAMP,                                  -- Data da última atualização do registro
    id_endereco_fk INTEGER NOT NULL,                             -- Referência ao endereço da clínica
    id_usuario_fk INTEGER NOT NULL,                              -- Referência ao usuário da clínica
    CONSTRAINT fk_endereco_clinica FOREIGN KEY (id_endereco_fk) REFERENCES T_Endereco(id_end),
    CONSTRAINT fk_usuario_clinica FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_usuario)
);

-- 13. Tabela de Médico
CREATE TABLE T_Medico (
    id_med INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,                                -- Nome do médico
    data_criacao TIMESTAMP NOT NULL,                            -- Data de criação do registro do médico
    data_atualizacao TIMESTAMP,                                 -- Data da última atualização do registro
    id_clinica_fk INTEGER,                                      -- Referência à clínica onde o médico trabalha
    id_especialidade_fk INTEGER NOT NULL,                       -- Referência à especialidade do médico
    id_genero_fk INTEGER NOT NULL,                              -- Referência ao gênero do médico
    id_usuario_fk INTEGER NOT NULL,                             -- Referência ao usuário associado ao médico
    CONSTRAINT fk_clinica_medico FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_especialidade_medico FOREIGN KEY (id_especialidade_fk) REFERENCES T_Especialidade(id_esp),
    CONSTRAINT fk_genero_medico FOREIGN KEY (id_genero_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_usuario_medico FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_usuario)
);

-- 14. Tabela de Login
CREATE TABLE T_Login (
    id_login INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_login TIMESTAMP NOT NULL,                             -- Data e hora da tentativa de login
    tipo_login VARCHAR2(1) NOT NULL,                           -- Indicador do sucesso ou falha do login (0 ou 1)
    id_usuario_fk INTEGER NOT NULL,                            -- Referência ao usuário que tentou o login
    CONSTRAINT fk_usuario_login FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_usuario)
);

-- 15. Tabela de Rotina de Cuidados
CREATE TABLE T_Rotina_Cuidado (
    id_rotina_cuidados INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    frequencia_escovacao VARCHAR2(50) NOT NULL,                          -- Frequência com que o cliente escova os dentes (diariamente, etc.)
    frequencia_fio_dental VARCHAR2(50) NOT NULL,                         -- Frequência do uso de fio dental pelo cliente
    frequencia_enxaguante VARCHAR2(50) NOT NULL,                         -- Frequência do uso de enxaguante bucal
    limpeza_profissional VARCHAR2(50) NOT NULL,                          -- Frequência de limpezas profissionais (ex: 3 meses, 6 meses, anual)
    id_cliente_fk INTEGER NOT NULL,                                      -- Referência ao cliente que tem essa rotina de cuidados
    CONSTRAINT fk_cliente_rotina_cuidado FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie)
);

-- 16. Tabela de Status
CREATE TABLE T_Status (
    id_status INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_status VARCHAR2(50) NOT NULL                          -- Descrição do status (ex: pendente, aceito, recusado)
);

-- 17. Tabela de Tarefas
CREATE TABLE T_Tarefa (
    id_tarefa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(255) NOT NULL,                          -- Descrição detalhada da tarefa
    pontuacao NUMBER(5) NOT NULL                               -- Pontuação atribuída à tarefa
);

-- 18. Tabela de Programa de Benefício
CREATE TABLE T_Programa_Beneficio (
    id_beneficio INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    data_inicio TIMESTAMP NOT NULL,                                -- Data de início do programa de benefício
    data_fim TIMESTAMP,                                            -- Data de término do programa
    condicao_aplicacao VARCHAR2(255) NOT NULL,                     -- Condições para aplicar o benefício
    status_beneficio NUMBER(1) NOT NULL,                           -- Status do benefício (0 ou 1)
    id_tarefa_fk INTEGER NOT NULL,                                 -- Referência à tarefa associada ao benefício
    id_medico_fk INTEGER NOT NULL,                                 -- Referência ao médico relacionado ao benefício
    CONSTRAINT fk_tarefa_beneficio_medico FOREIGN KEY (id_tarefa_fk) REFERENCES T_Tarefa(id_tarefa),
    CONSTRAINT fk_medico_beneficio FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med)
);

-- 19. Tabela de Tipo de Notificação
CREATE TABLE T_Tipo_Notificacao (
    id_tipo_notificacao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_tipo_notificacao VARCHAR2(50) NOT NULL                          -- Descrição do tipo de notificação (ex: app, SMS, email)
);

-- 20. Tabela de Notificações
CREATE TABLE T_Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  
    data_envio TIMESTAMP NOT NULL,                                    -- Data e hora de envio da notificação
    id_cliente_fk INTEGER NOT NULL,                                   -- Referência ao cliente que recebe a notificação
    id_status_fk INTEGER NOT NULL,                                    -- Referência ao status da notificação
    id_tipo_notificacao_fk INTEGER NOT NULL,                          -- Referência ao tipo de notificação
    CONSTRAINT fk_cliente_notificacao_cliente FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_status_notificacao_cliente FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status),
    CONSTRAINT fk_tipo_notificacao FOREIGN KEY (id_tipo_notificacao_fk) REFERENCES T_Tipo_Notificacao(id_tipo_notificacao)
);

-- 21. Tabela de Consulta Sugerida
CREATE TABLE T_Consulta_Sugerida (
    id_sugestao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Identificador único da sugestão de consulta, gerado automaticamente.
    data_consulta TIMESTAMP NOT NULL,                             -- Data e hora sugerida para a consulta, campo obrigatório.
    data_envio TIMESTAMP NOT NULL,                                -- Data e hora em que a sugestão foi enviada, campo obrigatório.
    data_alteracao TIMESTAMP NOT NULL,                            -- Data e hora da última alteração na sugestão, campo obrigatório.
    id_status_fk INTEGER NOT NULL,                                -- Referência ao status da sugestão, chave estrangeira.
    id_cliente_fk INTEGER NOT NULL,                               -- Referência ao cliente para quem a consulta é sugerida, chave estrangeira.
    id_medico_fk INTEGER NOT NULL,                                -- Referência ao médico relacionado à sugestão de consulta, chave estrangeira.
    CONSTRAINT fk_cliente_sugestao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_sugestao FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_status_sugestao FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 22. Tabela de Agendamento
CREATE TABLE T_Agendamento (
    id_agendamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Identificador único do agendamento, gerado automaticamente.
    data_sugerida TIMESTAMP NOT NULL,                               -- Data sugerida para o agendamento, campo obrigatório.
    data_resposta TIMESTAMP,                                        -- Data da resposta ao agendamento (aceito/rejeitado), campo opcional.
    id_cliente_fk INTEGER NOT NULL,                                 -- Referência ao cliente que solicitou o agendamento, chave estrangeira.
    id_medico_fk INTEGER NOT NULL,                                  -- Referência ao médico envolvido no agendamento, chave estrangeira.
    id_clinica_fk INTEGER NOT NULL,                                 -- Referência à clínica onde será realizado o agendamento, chave estrangeira.
    id_status_fk INTEGER NOT NULL,                                  -- Referência ao status do agendamento (pendente, aceito, recusado, etc.), chave estrangeira.
    CONSTRAINT fk_cliente_agendamento_medico FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_agendamento FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_agendamento FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_status_agendamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 23. Tabela de Consulta
CREATE TABLE T_Consulta (
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,   -- Identificador único da consulta, gerado automaticamente.
    data_consulta TIMESTAMP NOT NULL,                              -- Data e hora da consulta, campo obrigatório.
    valor DECIMAL(10, 2) NOT NULL,                                 -- Valor da consulta, campo obrigatório.
    status NUMBER(1) NOT NULL,                                     -- Status da consulta (0 = não realizada, 1 = realizada), campo obrigatório.
    id_cliente_fk INTEGER NOT NULL,                                -- Referência ao cliente que participou da consulta, chave estrangeira.
    id_medico_fk INTEGER NOT NULL,                                 -- Referência ao médico que realizou a consulta, chave estrangeira.
    CONSTRAINT fk_cliente_consulta_medico FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_consulta FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med)
);

-- 24. Tabela de Reagendamento
CREATE TABLE T_Reagendamento (
    id_reagendamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Identificador único do reagendamento, gerado automaticamente.
    id_agendamento INTEGER NOT NULL,                                   -- Referência ao agendamento original, chave estrangeira.
    data_anterior TIMESTAMP NOT NULL,                                 -- Data anterior ao reagendamento, campo obrigatório.
    horario_anterior VARCHAR2(50) NOT NULL,                          -- Horário anterior ao reagendamento, campo obrigatório.
    nova_data TIMESTAMP NOT NULL,                                     -- Nova data sugerida para o agendamento, campo obrigatório.
    novo_horario VARCHAR2(50) NOT NULL,                              -- Novo horário sugerido para o agendamento, campo obrigatório.
    id_status_fk INTEGER NOT NULL,                                    -- Status do reagendamento (pendente, aceito, recusado), chave estrangeira.
    data_criacao TIMESTAMP NOT NULL,                                 -- Data de criação do reagendamento, campo obrigatório.
    id_clinica_fk INTEGER NOT NULL,                                   -- Referência à clínica associada ao reagendamento, chave estrangeira.
    id_cliente_fk INTEGER NOT NULL,                                   -- Referência ao cliente que solicitou o reagendamento, chave estrangeira.
    id_medico_fk INTEGER,                                            -- (Opcional) Referência ao médico associado ao reagendamento, chave estrangeira.
    CONSTRAINT fk_agendamento_reagendamento FOREIGN KEY (id_agendamento) REFERENCES T_Agendamento(id_agendamento),
    CONSTRAINT fk_status_reagendamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status),
    CONSTRAINT fk_clinica_reagendamento FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_cliente_reagendamento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_reagendamento FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med)
);

-- 25. Tabela de Recusa
CREATE TABLE T_Recusa (
    id_recusa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Identificador único da recusa, gerado automaticamente.
    id_agendamento INTEGER NOT NULL,                              -- Referência ao agendamento recusado, chave estrangeira.
    motivo_recusa VARCHAR2(255) NOT NULL,                        -- Motivo da recusa, campo obrigatório.
    data_recusa TIMESTAMP NOT NULL,                              -- Data e hora da recusa, campo obrigatório.
    CONSTRAINT fk_agendamento_recusa FOREIGN KEY (id_agendamento) REFERENCES T_Agendamento(id_agendamento)
);

-- 25. Tabela de Cancelamento de Consulta
CREATE TABLE T_Cancelamento (
    id_cancelamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- Identificador único do cancelamento, gerado automaticamente.
    id_agendamento_fk INTEGER NOT NULL,                                -- Referência ao agendamento cancelado, chave estrangeira obrigatória.
    id_status_fk INTEGER NOT NULL,                                     -- Status do cancelamento, chave estrangeira obrigatória.
    id_medico_fk INTEGER,                                              -- Referência ao médico que solicitou o cancelamento (opcional), chave estrangeira.
    id_cliente_fk INTEGER,                                             -- Referência ao cliente que solicitou o cancelamento (opcional), chave estrangeira.
    desc_motivo_solicitacao VARCHAR2(255) NOT NULL,                  -- Motivo do cancelamento, campo obrigatório.
    data_cancelamento TIMESTAMP NOT NULL,                              -- Data e hora do cancelamento, campo obrigatório.
    CONSTRAINT fk_agendamento_cancelamento FOREIGN KEY (id_agendamento_fk) REFERENCES T_Agendamento(id_agendamento),
    CONSTRAINT fk_status_cancelamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status),
    CONSTRAINT fk_medico_cancelamento FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),  -- Relacionamento com médico (opcional).
    CONSTRAINT fk_cliente_cancelamento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie) -- Relacionamento com cliente (opcional).
);

-- 26. Tabela de Histórico de Avaliações
CREATE TABLE T_Historico_Avaliacao (
    id_avaliacao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,                                   -- Referência ao cliente que fez a avaliação
    id_medico_fk INTEGER NOT NULL,                                    -- Referência ao médico avaliado
    nota_medico INTEGER NOT NULL,                                     -- Nota do médico dada pelo cliente
    id_clinica_fk INTEGER NOT NULL,                                   -- Referência à clínica avaliada
    nota_clinica INTEGER NOT NULL,                                    -- Nota dada à clínica
    CONSTRAINT fk_cliente_avaliacao_medico FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_avaliacao_medico FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_avaliacao_medico FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica)
);

-- 27. Tabela de Pesquisa de Satisfação
CREATE TABLE T_Pesquisa (
    id_pesquisa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,    
    id_cliente_fk INTEGER NOT NULL,                                   -- Referência ao cliente que fez a pesquisa
    id_consulta_fk INTEGER NOT NULL,                                  -- Referência à consulta associada à pesquisa
    id_medico_fk INTEGER NOT NULL,                                    -- Referência ao médico avaliado
    nota_medico INTEGER NOT NULL,                                     -- Nota dada ao médico pelo cliente (0 a 5).
    id_clinica_fk INTEGER NOT NULL,                                   -- Referência à clínica avaliada
    nota_clinica INTEGER NOT NULL,                                    -- Nota dada à clínica (0 a 5).
    comentario VARCHAR2(500),                                         -- Comentários adicionais do cliente, campo opcional.
    data_pesquisa TIMESTAMP NOT NULL,                                 -- Data em que a pesquisa foi realizada
    CONSTRAINT fk_cliente_pesquisa_satisfacao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_consulta_pesquisa_satisfacao FOREIGN KEY (id_consulta_fk) REFERENCES T_Consulta(id_consulta),
    CONSTRAINT fk_medico_pesquisa_satisfacao FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_pesquisa_satisfacao FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica)
);


