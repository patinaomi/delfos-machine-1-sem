package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

@Data
public class FeedbackRequest extends RepresentationModel<FeedbackRequest> {

    @NotNull(message = "Cliente não pode ser nulo")
    private Cliente cliente;

    @NotNull(message = "Dentista não pode ser nulo")
    private Dentista dentista;

    @NotNull(message = "Clínica não pode ser nula")
    private Clinica clinica;

    @NotNull(message = "Avaliação não pode ser nula")
    private Float avaliacao;

    @Size(max = 250, message = "O comentário deve ter no máximo 250 caracteres")
    private String comentario;
}
