package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Clinica;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface ClinicaRepository extends JpaRepository<Clinica, String> {

    @Procedure(name = "inserir_clinica")
    void inserirClinica(String nome, String endereco, String telefone, Float avaliacao, Double precoMedio);

    @Procedure(name = "atualizar_clinica")
    void atualizarClinica(String idClinica, String nome, String endereco, String telefone, Float avaliacao, Double precoMedio);

    @Procedure(name = "deletar_clinica")
    void deletarClinica(String idClinica);
}
