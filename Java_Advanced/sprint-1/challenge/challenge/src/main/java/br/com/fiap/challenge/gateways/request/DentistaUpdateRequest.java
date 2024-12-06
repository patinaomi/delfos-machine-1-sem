package br.com.fiap.challenge.gateways.request;

import lombok.Data;

@Data
public class DentistaUpdateRequest {

    private String nome;

    private String sobrenome;

    private String telefone;

    private Float avaliacao;
}
