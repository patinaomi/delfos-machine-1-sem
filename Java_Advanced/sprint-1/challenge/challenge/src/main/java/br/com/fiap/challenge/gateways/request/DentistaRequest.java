package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Especialidade;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class DentistaRequest {

    @NotNull(message = "Nome não pode ser nulo")
    private String nome;

    @NotNull(message = "Sobrenome não pode ser nulo")
    private String sobrenome;

    @NotNull(message = "Telefone não pode ser nulo")
    private String telefone;

    @NotNull(message = "Clínica não pode ser nula")
    private Clinica clinica;

    @NotNull(message = "Especialidade não pode ser nula")
    private Especialidade especialidade;

    private Float avaliacao;
}
