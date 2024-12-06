package br.com.fiap.challenge.gateways.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class FormularioDetalhadoUpdateRequest {

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
