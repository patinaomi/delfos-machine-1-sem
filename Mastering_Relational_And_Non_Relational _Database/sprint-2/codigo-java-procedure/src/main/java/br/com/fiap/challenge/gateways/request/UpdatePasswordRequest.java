package br.com.fiap.challenge.gateways.request;

import lombok.Data;

@Data
public class UpdatePasswordRequest {
    private String clienteId;
    private String novaSenha;
}
