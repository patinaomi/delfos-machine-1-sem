package br.com.fiap.challenge.gateways.response;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import lombok.Builder;

import java.time.LocalDate;

@Builder
public record ConsultaResponse(
        Long idConsulta,
        Cliente cliente,
        Clinica clinica,
        Dentista dentista,
        String tipoServico,
        LocalDate dataConsulta,
        char statusConsulta,
        String observacoes,
        String sintomas,
        String tratamentoRecomendado,
        Double custo,
        String prescricao,
        LocalDate dataRetorno
) {}
