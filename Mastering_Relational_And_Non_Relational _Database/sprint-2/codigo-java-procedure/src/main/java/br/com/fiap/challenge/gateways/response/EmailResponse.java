package br.com.fiap.challenge.gateways.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class EmailResponse {
    private String message;
    private String email;
    private boolean emailExists;
}
