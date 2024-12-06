package br.com.fiap.challenge.gateways.response;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import lombok.Builder;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

@Builder
@Data
public class FeedbackResponse extends RepresentationModel<FeedbackResponse> {

        Cliente cliente;
        Dentista dentista;
        Clinica clinica;
        Float avaliacao;
        String comentario;
}
