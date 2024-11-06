package br.com.fiap.challenge.gateways.response;

import lombok.Builder;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.math.BigDecimal;

@Data
@Builder
public class ClinicaResponse extends RepresentationModel<ClinicaResponse> {

    private String nome;
    private String endereco;
    private String telefone;
    private Double avaliacao;
    private Double precoMedio;
}
