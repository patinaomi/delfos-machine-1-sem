package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.EstadoCivil;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class FormularioDetalhadoRequest extends RepresentationModel<FormularioDetalhadoRequest> {

    @NotNull(message = "Cliente não pode ser nulo")
    private Cliente cliente;

    @NotNull(message = "Estado civil não pode ser nulo")
    private EstadoCivil estadoCivil;

    private String historicoFamiliar;
    private String profissao;
    private Double rendaMensal;
    private String historicoMedico;
    private String alergia;
    private String condicaoPreexistente;
    private String usoMedicamento;
    private String familiarComDoencasDentarias;
    private Character participacaoEmProgramasPreventivos;
    private String contatoEmergencial;
    private Character pesquisaSatisfacao;
    private LocalDate dataUltimaAtualizacao;
    private Character frequenciaConsultaPeriodica;
    private String sinalizacaoDeRisco;
    private String historicoDeViagem;
    private String historicoDeMudancasDeEndereco;
    private String preferenciaDeContato;
}
