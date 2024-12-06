package br.com.fiap.challenge.gateways.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;

@Data
public class ConsultaUpdateRequest {

    private String tipoServico;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataConsulta;

    private Character statusConsulta;

    private String observacoes;

    private String sintomas;

    private String tratamentoRecomendado;

    private Double custo;

    private String prescricao;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataRetorno;
}
