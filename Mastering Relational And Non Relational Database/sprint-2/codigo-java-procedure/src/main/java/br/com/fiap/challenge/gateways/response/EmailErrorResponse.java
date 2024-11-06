package br.com.fiap.challenge.gateways.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class EmailErrorResponse {
    String message;
    boolean emailExists;
}
