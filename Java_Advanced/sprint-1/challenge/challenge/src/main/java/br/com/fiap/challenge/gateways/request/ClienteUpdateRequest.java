package br.com.fiap.challenge.gateways.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;

@Data
public class ClienteUpdateRequest {

    private String nome;

    private String sobrenome;

    private String email;

    private String telefone;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataNasc;

    private String endereco;

}
