package br.com.fiap.challenge.gateways.request;

import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

@Data
public class FeedbackUpdateRequest extends RepresentationModel<FeedbackUpdateRequest> {

    private Float avaliacao;

    @Size(max = 250, message = "O comentário deve ter no máximo 250 caracteres")
    private String comentario;
}
