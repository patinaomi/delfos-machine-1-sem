package br.com.fiap.challenge.gateways.response;

import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Especialidade;
import lombok.Builder;

@Builder
public record DentistaResponse(
        Long idDentista,
        String nome,
        String sobrenome,
        String telefone,
        Clinica clinica,
        Especialidade especialidade,
        Float avaliacao
) {}
