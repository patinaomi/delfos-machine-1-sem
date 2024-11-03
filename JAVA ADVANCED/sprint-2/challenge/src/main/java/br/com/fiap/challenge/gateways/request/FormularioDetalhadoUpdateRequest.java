package br.com.fiap.challenge.gateways.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class FormularioDetalhadoUpdateRequest extends RepresentationModel<FormularioDetalhadoUpdateRequest> {

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

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataUltimaAtualizacao;

    private Character frequenciaConsultaPeriodica;

    @Size(max = 250, message = "A sinalização de risco deve ter no máximo 250 caracteres")
    private String sinalizacaoDeRisco;

    @Size(max = 250, message = "O histórico de viagem deve ter no máximo 250 caracteres")
    private String historicoDeViagem;

    @Size(max = 250, message = "O histórico de mudanças de endereço deve ter no máximo 250 caracteres")
    private String historicoDeMudancasDeEndereco;

    @Size(max = 250, message = "O histórico de mudanças de telefone deve ter no máximo 250 caracteres")
    private String preferenciaDeContato;
}
