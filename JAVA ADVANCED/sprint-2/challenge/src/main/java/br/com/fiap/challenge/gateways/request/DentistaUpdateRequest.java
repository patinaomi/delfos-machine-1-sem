package br.com.fiap.challenge.gateways.request;

import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

@Data
public class DentistaUpdateRequest extends RepresentationModel<DentistaUpdateRequest> {

    private String nome;

    private String sobrenome;

    private String telefone;

    private Float avaliacao;
}
