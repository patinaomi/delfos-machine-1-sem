package br.com.fiap.challenge.gateways.request;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String senha;
    private String id;

}
