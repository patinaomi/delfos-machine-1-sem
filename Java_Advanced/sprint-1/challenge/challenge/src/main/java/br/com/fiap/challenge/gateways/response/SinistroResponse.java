package br.com.fiap.challenge.gateways.response;

import br.com.fiap.challenge.domains.Consulta;
import lombok.Builder;

import java.time.LocalDate;

@Builder
public record SinistroResponse(
        Long idSinistro,
        Consulta consulta,
        String nome,
        String descricao,
        char statusSinistro,
        String descricaoStatus,
        Double valorSinistro,
        LocalDate dataAbertura,
        LocalDate dataResolucao,
        String documentacao
) {}
