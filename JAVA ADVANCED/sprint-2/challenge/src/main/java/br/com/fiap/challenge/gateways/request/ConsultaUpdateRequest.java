package br.com.fiap.challenge.gateways.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class ConsultaUpdateRequest extends RepresentationModel<ConsultaUpdateRequest> {

    private String tipoServico;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataConsulta;

    private Character statusConsulta;

    @Size(max = 250, message = "As observações devem ter no máximo 250 caracteres")
    private String observacoes;

    @Size(max = 250, message = "Os sintomas devem ter no máximo 250 caracteres")
    private String sintomas;

    @Size(max = 250, message = "O tratamento recomendado deve ter no máximo 250 caracteres")
    private String tratamentoRecomendado;

    private Double custo;

    @Size(max = 250, message = "A prescrição deve ter no máximo 250 caracteres")
    private String prescricao;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataRetorno;
}
