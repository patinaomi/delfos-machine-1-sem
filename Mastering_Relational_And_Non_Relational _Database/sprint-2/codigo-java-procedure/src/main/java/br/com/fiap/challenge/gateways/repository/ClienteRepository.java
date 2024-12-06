package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, String> {

    Cliente findByEmailAndDataNasc(String email, LocalDate dataNasc);


    Cliente findByEmail(String email);

    @Procedure(name = "inserir_cliente")
    void inserirCliente(
            String p_nome,
            String p_sobrenome,
            String p_email,
            String p_telefone,
            LocalDate p_data_nasc,
            String p_endereco
    );

    @Procedure(name = "atualizar_cliente")
    void atualizarCliente(
            String p_id_cliente,
            String p_nome,
            String p_sobrenome,
            String p_email,
            String p_telefone,
            LocalDate p_data_nasc,
            String p_endereco
    );

    @Procedure(name = "deletar_cliente")
    void deletarCliente(String p_id_cliente);

}
