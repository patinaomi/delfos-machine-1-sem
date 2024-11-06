package br.com.fiap.challenge.gateways.response;

import lombok.Builder;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;
import java.sql.Date;

@Builder
@Data
public class ClienteResponse extends RepresentationModel<ClienteResponse> {

    String nome;
    String sobrenome;
    String email;
    String telefone;
    LocalDate dataNasc;
    String endereco;
}
