package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class ConsultaRequest extends RepresentationModel<ConsultaRequest> {

    @NotNull(message = "Cliente não pode ser nulo")
    private Cliente cliente;

    @NotNull(message = "Clínica não pode ser nula")
    private Clinica clinica;

    @NotNull(message = "Dentista não pode ser nulo")
    private Dentista dentista;

    @NotNull(message = "Tipo de serviço não pode ser nulo")
    private String tipoServico;

    @NotNull(message = "Data da consulta não pode ser nula")
    private LocalDate dataConsulta;

    private Character statusConsulta;
    private String observacoes;
    private String sintomas;
    private String tratamentoRecomendado;
    private Double custo;
    private String prescricao;
    private LocalDate dataRetorno;
}
