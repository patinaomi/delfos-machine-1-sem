
// Processo com a experiência isolada do cliente

-- o que virá do formulario de cadastro
tabelaCadastroCliente
id_cadastro pk
id_cliente fk -- vai ser fk pq a chave pk precisa estar na tabela Cliente
nome_cliente
telefone_cliente
email_cliente
cpf_cliente
id_genero_cliente
data_nascimento
-- o formuálario vai coletar o endereço mas não vai salvar na tabela cliente e sim na tabela endereco. Será normalizado na propria tabela de endereco
cep_residencia_cliente
numero
rua
bairro
complemento
cidade
estado
senha

-- Será alimentado pelo formulário de preferencia -- vc fez separado no prototipo
tabelaPreferenciaEnderecoCliente
id_cliente fk
id_endereco_preferencia pk
data_cadastro
data_atualizacao -- quando ele mudar de preferencia
cep_endereco_preferencia
numero_endereco_preferencia
rua_endereco_preferencia
bairro_endereco_preferencia
complemento_endereco_preferencia
cidade_endereco_preferencia
estado_endereco_preferencia

-- Genero
tabelaGenero
id_genero
desc_genero - só masculino e feminino


-- Tabela Logs do Sistema -- saber quando o cliente realizou o login
tabelaHistoricoLogin
id_log (PK)
id_usuario (FK - cliente ou clínico)
data_evento
tipo_evento -- login efetuado ou tentativa?
-- Teremos a tela inicial do usuario cliente e no site a tela de login da cliente.

-- Formulário preferencia de atendimento
tabelaPreferenciaAtendimento
id_preferencia_atendimento pk
id_cliente fk
dia -- Precisamos normalizar?
id_turno_preferencia_atendimento -- somente manha, tarde e noite. Será que precisamos normalizar?
id_tipo_atendimento fk

-- tabela com o tipo de atendimento
id_tipo_atendimento pk
desc_tipo_atendimento -- presencial ou remoto

-- Tabela com o turno do atendimento
id_turno_prerencia_atendimento
desc_turno_preferencia -- manha, tarde ou noite

-- Formulário rotina de cuidados
id_rotina_cuidados
id_cliente fk
frequencia_escovacao
frequencia_fio_dental
id_turno_prerencia_atendimento_enxaguante fk
limpeza_profissional -- opcoes 3 meses, 6 meses ou uma vez ao ano.


// Processo para clinica e especialista


-- Tabela única de endereço para cliente, clinica e especialista
endereco
id_endereco
id_cliente -- para endereco do cliente
id_clinica -- para endereco da clinica
id_medido -- para endereco do medico
cep
estado
cidade
bairro
rua
numero
complemento

endereco de preferencia -- precisa dela para treinar o modelo
id_endereco_preferencia pf
id_cliente
cep_preferencia
estado_preferencia
cidade_preferencia
bairro_prereferencia
rua_preferencia
numero_preferencia
complemento_preferencia


-- formualario para cadastrar a clinica na nossa aplicação web
id_clinica (PK)
nome_clinica
telefone_clinica
cpf_cnpj_clinica
email
cep
estado
cidade
bairro
rua
numero
complemento
disponibilidade_horario
disponibilidade_dia
data_criacao
data_atualizacao_cadastro
especialidades -- vai ter uma lista com as especialidade

-- formulario de cadastro dos médicos
id_medico (PK)
id_especialidade fk
nome_medico
especialidade
id_clinica (FK) -- Precisa informar no formulario se possui uma clinica filiada a ele.
data_criacao


-- Tabela Especialidades Médicas
id_especialidade (PK)
descricao_especialidade

-- Tabela Relacionamento Médico-Especialidade
id_relacao (PK)
id_medico (FK)
id_especialidade (FK)

-- tabela para gestão da clinica, como atualizacao de dados e tudo mais. Igual cliente. O formulário de cadastro só grava e não tem mais nenhuma 
-- acao como atualizar, deletar.
-- Sera legal ter usuario e nela ter cliente, especialista e clinica? par fazer o crud

-- um cliente, clinica e medico pode ser alterado, excluido, mas cadastro nunca poderá ser excluido.
tabelaUsuario
id_usuario pk
id_cliente fk
id_clinica
id_medico
nome
email
telefone
senha
id_endereco_residencia
id_endereco_preferencia
id_genero
id_endereco
cpf_cnpj
data_nascimento
data_atualizacao

-- tabela de usuario com permissões
-- Tabela Usuário (para gerenciamento de acesso)
id_usuario_perfil (PK)
id_cliente fk
nome_usuario
email
senha
id_perfil (cliente, administrador, clínico, secretaria, auxiliar, medico) fk
data_criacao
data_atualizacao

-- tabela perfil
id_perfil (cliente, administrador, clínico) pk
desc_perfil

// Sugestão do atendimento

-- Tabela Clínicas Sugeridas -- aqui é onde o motor vai rodar, diferente da outra que vai marcar o agendamento efetivado.
id_sugestao (PK)
id_cliente (FK)
id_clinica (FK)
id_medico
id_especialidade
id_status_sugestao (em acionamento, aceita, rejeitada )
data_envio_sugestao
data_alteracao_status -- seja com aceite, recusa

-- status sugestao
id_status_sugestao (enviada, rejeitada, aceita)
desc_sugestao
-- precisamos saber se nossa IA está funcionando com as sugestões

--Tabela Agendamento -- sugestao que vai aparecer na tela do usuario, diferente da consulta que é quando ambos os lados aceitaram
id_agendamento (PK)
id_cliente (FK)
id_medico (FK)
id_clinica (FK)
data_sugerida
horario_sugerido
id_status_agendamento (aceito, recusado, em acionamento) fk -- se pendente, terá o prazo de 24 horas para alteracão e realizar nova busca no sistema
-- se recusar, precisar inserir o motivo
id_motivo_recusa_cliente fk
id_motivo_recusa_clinica fk
data_resposta
hora_resposta
data_criacao -- diferente dos dois de cima. Aqui foi quando o motor rodou a pesquisa para gerar o agendamento

-- Tabela Agenda da Clínica
id_agenda (PK)
id_clinica (FK)
data_disponivel
horario_disponivel
status_agenda

-- nos cenários que eles só usarem nossa aplicação.

-- status do agendamento
id_agendamento
desc_agendamento -- (aceito, recusado, pendente) 
-- Quando a clinica receber o alerta da consulta, vai avaliar a data e horario de preferencia do cliente
-- precisa falar se aceita ou recusa. Se aceitar, vai a notificação para o cliente tambem aceitar
-- se recusar, precisa falar o motivo da recusa.

-- motivo recusa
id_motivo pk
id_motivo_recusa_cliente 
id_motivo_recusa_clinica
desc_motivo

-- Tabela Recusa -- salvar histórico das recusas para treinar o modelo
id_recusa (PK)
id_agendamento (FK)
tipo_recusa (cliente ou clínica)
motivo_recusa
data_recusa

-- Tabela Histórico de Consultas -- que mostra na tela do usuário
id_historico (PK)
id_cliente (FK)
id_medico (FK)
id_clinica (FK)
data_consulta
avaliacao_cliente
comentarios_cliente

-- Tabela Notificações
id_notificacao (PK)
id_cliente (FK)
id_agendamento (FK)
id_tipo_notificacao (lembrete, agendamento, cancelamento)
id_status (pendente, enviado, lido)
data_envio

-- tabela tipo de notificação 
id_tipo_notificacao pk
desc_tipo_notificacao 

-- Tabela Preferências de Notificações -- ter isso no app e no site para selecionar por um formulário
id_preferencia_notificacao (PK)
id_cliente (FK)
id_tipo_notificacao (SMS, e-mail, push)
status_preferencia -- ativa ou desativada
data_atualizacao

-- tabela de preferencia de agendamento normalizada
id_tipo_notificacao (SMS, e-mail, push) pk
desc_preferencia_notificacao

-- tabela status da notificação
id_status_notificao
desc_status_notificacao --  (pendente, enviado, lido)

-- agora processos que teremos no motor de busca

-- Tabela Reagendamento -- precisa existir um botao que tenha a opcao de reagendar, igual do espaco leaser.
id_reagendamento (PK)
id_agendamento (FK)
data_anterior
horario_anterior
nova_data
novo_horario
id_status_reagendamento (solicitado, aceito, recusado) fk
data_criacao
id_pessoa -- quem pediu para reagendar? clinica ou cliente

--tabela status reeagendamento
id_status_reagendamento pk
desc_status_reagendamento --(solicitado, aceito, recusado) 

-- tabela de cancelamento da consulta
id_cancelamento pk
id_agendamento fk
id_status_cancelamento
id_pessoa_solicitante -- clinica, médico ou cliente?
desc_motivo_solicitacao -- pq foi solicitado o cancelamento (teremos um pop-up que fará essa pergunta na hora de cancelar.
data_cancelamento

// Consulta

-- tabela da consulta, o agendamento é só o processo de sugestão
id_consulta
id_cliente
id_especialista
id_status_consulta
data
hora
nota
valor

-- tabela com status da consulta
id_status_consulta
desc_status_consulta (pendente, concluida, cancelada)

// feedback

-- Tabela Pesquisa de Satisfação -- aqui é do formulario de feedback
id_pesquisa (PK)
id_cliente (FK)
id_consulta (FK)
ter a pergunta o quanto recomenda o médico
id_medico -- precisa mostrar quem vai receber a nota
nota_medico
ter pergunta o quanto recomenda a clinica
id_clinica
nota_clinica -- será de 0 a 5
comentarios
data_pesquisa


-- Tabela Histórico de Avaliações -- aqui será o histórico que precisamos alimentar no motor e nos dados do médico
id_avaliacao (PK)
id_cliente (FK)
id_medico (FK)
nota_medico
id_clinica (FK)
nota_clinica
media_nota -- precisamos pois o motor vai usar esse campo para sugerir ou não uma clinica.


 -- Tabela Sessões de Usuário empresa
 -- preciso saber se a clinica está online pois senão, nunca vai aceitar nossas sugestoes.
id_sessao (PK)
id_usuario (FK)
data_inicio
data_fim
id_status_sessao (ativa, encerrada)
ip_usuario

-- sera coletado isso pelo site e não pelo app. Não precisa usar aqui em java

-- tabela status sessao
id_status_sessao (ativa, encerrada)
desc_sessao

-- Tabela programa de beneficio
id_tarefa fk
id_cliente
id_especialista
id_clinica
data_inicio
data_fim
condicoes_aplicacao
id_status_tarefa fk

-- tabela terafas
id_tarefa pk
desc_tarefa 
-- exmeplo: precisa preencher o cadastro, temos que saber se ele fez isso ou não

id_status_tarefa
desc_status_tarefa -- está pendente ou concluiu?

-- Tabela Parcerias
id_parceria (PK)
nome_parceiro
id_tipo_parceria (convênio, promoção, especialista)
descricao
data_inicio
data_fim
data_cadastro

-- tabela tipo de parceria
id_tipo_parceria (convênio, promoção, especialista)
desc_tipo_parceria
-- precisamos saber quem criou os conteudos, quando, o que vai ganhar com isso, de foi validado.

-- Tabela Sistema de Recompensas
id_recompensa (PK)
id_cliente (FK)
pontos_acumulados
descricao_recompensa
data_atualizacao


