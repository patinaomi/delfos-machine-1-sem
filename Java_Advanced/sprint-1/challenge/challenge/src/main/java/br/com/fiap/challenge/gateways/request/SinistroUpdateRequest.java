package br.com.fiap.challenge.gateways.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class SinistroUpdateRequest {

    private String nome;
    private String descricao;
    private Character statusSinistro;
    private String descricaoStatus;
    private Double valorSinistro;
    private LocalDate dataAbertura;
    private LocalDate dataResolucao;
    private String documentacao;
}
