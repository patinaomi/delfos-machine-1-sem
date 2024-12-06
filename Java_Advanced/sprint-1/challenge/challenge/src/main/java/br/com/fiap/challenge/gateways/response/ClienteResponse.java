package br.com.fiap.challenge.gateways.response;

import lombok.Builder;

import java.time.LocalDate;

@Builder
public record ClienteResponse(
        String nome,
        String sobrenome,
        String email,
        String telefone,
        LocalDate dataNasc,
        String endereco
)
{
}
