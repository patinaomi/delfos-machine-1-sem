package br.com.fiap.challenge.gateways.request;

import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

@Data
public class FeedbackUpdateRequest extends RepresentationModel<FeedbackUpdateRequest> {

    private Float avaliacao;

    private String comentario;
}
