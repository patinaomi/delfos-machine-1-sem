package br.com.fiap.challenge.gateways.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ValidateUserRequest {
    private String email;
    private LocalDate dataNasc;
}
