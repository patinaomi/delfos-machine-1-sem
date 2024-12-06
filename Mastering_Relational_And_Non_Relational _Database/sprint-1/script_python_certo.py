#--------------------( Importações necessárias )--------------------#

import pandas as pd
import oracledb

# Minhas credenciais
credencial_banco = {
    'dsn': 'oracle.fiap.com.br:1521/orcl',
    'usuario': 'rm553472',
    'senha': '100593'
}

# Função para conectar ao banco de dados
def conectar(usuario, senha, dsn):
    try:
        conexao = oracledb.connect(user=usuario, password=senha, dsn=dsn, mode=oracledb.DEFAULT_AUTH)
        print("Conexão com o banco de dados Oracle estabelecida com sucesso.")
        return conexao
    except oracledb.DatabaseError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Função para manipular a tabela
def manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados):
    cursor = conexao.cursor()
    try:
        # Verificar se a tabela existe e excluí-la se necessário
        cursor.execute(f"""
            BEGIN
                EXECUTE IMMEDIATE 'DROP TABLE {nome_tabela} CASCADE CONSTRAINTS';
            EXCEPTION
                WHEN OTHERS THEN
                    IF SQLCODE != -942 THEN 
                        RAISE;
                    END IF;
            END;
        """)
        print(f"Tabela '{nome_tabela}' excluída, se existia.")

        # Criar a nova tabela
        cursor.execute(query_criacao)
        print(f"Tabela '{nome_tabela}' criada com sucesso!")

        # Executar a inserção
        for registro in dados:
            cursor.execute(query_inserir, registro)

        # Commit das alterações
        conexao.commit()
        print("Dados inseridos com sucesso.")

    except oracledb.DatabaseError as e:
        print(f"Erro ao manipular a tabela: {e}")
        conexao.rollback()  # Desfazer alterações em caso de erro

    finally:
        # Fechar o cursor
        cursor.close()

# Função para consultar dados
def consultar_dados(cursor, nome_tabela):
    cursor.execute(f"SELECT * FROM {nome_tabela}")
    resultados = cursor.fetchall()

    if resultados:
        print(f"\nResultados da tabela {nome_tabela}:")
        for row in resultados:
            if nome_tabela == "CLIENTE":
                print(f"ID Cliente: {row[0]}")
                print(f"Nome: {row[1]}")
                print(f"Email: {row[2]}")
                print(f"Telefone: {row[3]}")
                print(f"Data de Nascimento: {row[4]}")
                print(f"Endereço: {row[5]}\n")
            elif nome_tabela == "FEEDBACK":
                print(f"ID Feedback: {row[0]}")
                print(f"ID Cliente: {row[1]}")
                print(f"Comentário: {row[2]}")
                print(f"Avaliação: {row[3]}")
                print(f"Data do Feedback: {row[4]}\n")
    else:
        print(f"Nenhum resultado encontrado na tabela {nome_tabela}.")

# Menu principal
def menu(conexao):
    try:
        while True:
            print("\nMenu:")
            print("1. Criar e inserir dados na tabela CLIENTE")
            print("2. Criar e inserir dados na tabela FEEDBACK")
            print("3. Consultar dados da tabela CLIENTE")
            print("4. Consultar dados da tabela FEEDBACK")
            print("5. Sair")

            opcao = input("Escolha uma opção (somente números): ")

            # Verifica se a entrada é um número
            if opcao.isdigit():
                opcao = int(opcao)
                if opcao in range(1, 8):
                    print(f"Você escolheu a opção {opcao}.")
                    if opcao == 1:
                        # Inserir os dados dos clientes
                        nome_tabela = "CLIENTE"
                        query_criacao = """
                            CREATE TABLE CLIENTE ( 
                                ID_Cliente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
                                Nome VARCHAR2(100) NOT NULL, 
                                Email VARCHAR2(100) NOT NULL, 
                                Telefone VARCHAR2(15), 
                                Data_Nascimento DATE, 
                                Endereco VARCHAR2(255) 
                            )
                        """
                        query_inserir = """
                            INSERT INTO CLIENTE (Nome, Email, Telefone, Data_Nascimento, Endereco)
                            VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5)
                        """
                        # Dados de exemplo para 10 clientes
                        dados_cliente = [
                            ('Cliente 1', 'cliente1@example.com', '123456789', '1980-01-01', 'Rua A, 123'),
                            ('Cliente 2', 'cliente2@example.com', '123456780', '1981-02-02', 'Rua B, 234'),
                            ('Cliente 3', 'cliente3@example.com', '123456771', '1982-03-03', 'Rua C, 345'),
                            ('Cliente 4', 'cliente4@example.com', '123456762', '1983-04-04', 'Rua D, 456'),
                            ('Cliente 5', 'cliente5@example.com', '123456753', '1984-05-05', 'Rua E, 567'),
                            ('Cliente 6', 'cliente6@example.com', '123456744', '1985-06-06', 'Rua F, 678'),
                            ('Cliente 7', 'cliente7@example.com', '123456735', '1986-07-07', 'Rua G, 789'),
                            ('Cliente 8', 'cliente8@example.com', '123456726', '1987-08-08', 'Rua H, 890'),
                            ('Cliente 9', 'cliente9@example.com', '123456717', '1988-09-09', 'Rua I, 901'),
                            ('Cliente 10', 'cliente10@example.com', '123456708', '1989-10-10', 'Rua J, 012')
                        ]
                        manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados_cliente)

                    elif opcao == 2:
                        # Inserir dados para feedback
                        nome_tabela = "FEEDBACK"
                        query_criacao_feedback = """
                            CREATE TABLE FEEDBACK (
                                id_feedback NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                                id_cliente NUMBER NOT NULL,
                                comentario VARCHAR2(250),
                                avaliacao NUMBER CHECK (avaliacao BETWEEN 1 AND 5),
                                data_feedback TIMESTAMP NOT NULL,
                                CONSTRAINT fk_feedback_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(ID_Cliente)
                            )
                        """
                        query_inserir_feedback = """
                            INSERT INTO FEEDBACK (id_cliente, comentario, avaliacao, data_feedback)
                            VALUES (:1, :2, :3, TO_TIMESTAMP(:4, 'YYYY-MM-DD HH24:MI:SS'))
                        """
                        # Dados de exemplo para feedbacks
                        dados_feedback = [
                            (1, 'Ótimo atendimento!', 5, '2024-10-01 09:00:00'),
                            (2, 'Consulta boa, mas poderia ser mais rápida.', 4, '2024-10-02 10:00:00'),
                            (3, 'O dentista foi muito atencioso.', 5, '2024-10-03 11:00:00'),
                            (1, 'Esperava mais clareza nas instruções.', 3, '2024-10-04 14:00:00'),
                            (2, 'Serviço de limpeza foi excelente!', 5, '2024-10-05 15:00:00')
                        ]
                        manipular_tabela(conexao, nome_tabela, query_criacao_feedback, query_inserir_feedback, dados_feedback)

                    elif opcao == 3:
                        # Consultar dados na tabela CLIENTE
                        consultar_dados(conexao.cursor(), "CLIENTE")

                    elif opcao == 4:
                        # Consultar dados na tabela FEEDBACK
                        consultar_dados(conexao.cursor(), "FEEDBACK")

                    elif opcao == 5:
                        print("Saindo do programa.")
                        break

                    else:
                        print("Opção inválida, tente novamente.")
            else:
                print("Por favor, insira apenas números.")
    finally:
        if conexao:
            conexao.close()
            print("Conexão com o banco de dados fechada.")

# Conectar ao banco de dados
conexao = conectar(credencial_banco['usuario'], credencial_banco['senha'], credencial_banco['dsn'])
if conexao:
    menu(conexao)
