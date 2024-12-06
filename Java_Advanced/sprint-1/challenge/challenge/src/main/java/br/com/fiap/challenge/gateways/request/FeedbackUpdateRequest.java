package br.com.fiap.challenge.gateways.request;

import lombok.Data;

@Data
public class FeedbackUpdateRequest {

    private Float avaliacao;

    private String comentario;
}
