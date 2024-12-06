package br.com.fiap.challenge.gateways.response;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import lombok.Builder;

@Builder
public record FeedbackResponse(
        Long idFeedback,
        Cliente cliente,
        Dentista dentista,
        Clinica clinica,
        Float avaliacao,
        String comentario
) {}
