package br.com.fiap.challenge.gateways.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class ClinicaRequest {

    @NotNull(message = "O nome da clínica não pode ser nulo")
    @Size(max = 100, message = "O nome da clínica deve ter no máximo 100 caracteres")
    private String nome;

    @NotNull(message = "O endereço da clínica não pode ser nulo")
    @Size(max = 255, message = "O endereço da clínica deve ter no máximo 255 caracteres")
    private String endereco;

    @NotNull(message = "O telefone da clínica não pode ser nulo")
    @Size(max = 15, message = "O telefone da clínica deve ter no máximo 15 caracteres")
    private String telefone;

    private Double avaliacao;

    private Double precoMedio;
}
