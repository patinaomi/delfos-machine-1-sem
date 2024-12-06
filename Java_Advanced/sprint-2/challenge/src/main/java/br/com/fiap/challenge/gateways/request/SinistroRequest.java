package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Consulta;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class SinistroRequest extends RepresentationModel<SinistroRequest> {

    @NotNull(message = "Consulta não pode ser nula")
    private String consulta;

    @NotNull(message = "Nome não pode ser nulo")
    @Size(max = 100, message = "O nome do sinistro deve ter no máximo 100 caracteres")
    private String nome;

    @Size(max = 250, message = "A descrição do sinistro deve ter no máximo 250 caracteres")
    private String descricao;

    private Character statusSinistro;

    @Size(max = 250, message = "A descrição do status do sinistro deve ter no máximo 250 caracteres")
    private String descricaoStatus;

    private Double valorSinistro;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataAbertura;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataResolucao;

    @Size(max = 250, message = "A documentação do sinistro deve ter no máximo 250 caracteres")
    private String documentacao;
}
