package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Consulta;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class SinistroRequest {

    @NotNull(message = "Consulta não pode ser nula")
    private Consulta consulta;

    @NotNull(message = "Nome não pode ser nulo")
    private String nome;

    private String descricao;
    private Character statusSinistro;
    private String descricaoStatus;
    private Double valorSinistro;
    private LocalDate dataAbertura;
    private LocalDate dataResolucao;
    private String documentacao;
}
