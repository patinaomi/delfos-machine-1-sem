package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.EstadoCivil;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class FormularioDetalhadoRequest extends RepresentationModel<FormularioDetalhadoRequest> {

    @NotNull(message = "Cliente não pode ser nulo")
    private Cliente cliente;

    @NotNull(message = "Estado civil não pode ser nulo")
    private EstadoCivil estadoCivil;

    @Size(message = "O histórico familiar deve ter no máximo 250 caracteres")
    private String historicoFamiliar;

    @Size(message = "A profissão deve ter no máximo 100 caracteres")
    private String profissao;

    private Double rendaMensal;

    @Size(message = "O histórico médico deve ter no máximo 250 caracteres")
    private String historicoMedico;

    @Size(message = "Alergia deve ter no máximo 100 caracteres")
    private String alergia;

    @Size(message = "A medicação deve ter no máximo 100 caracteres")
    private String condicaoPreexistente;

    @Size(message = "O uso de medicamento deve ter no máximo 100 caracteres")
    private String usoMedicamento;

    @Size(message = "O histórico odontológico deve ter no máximo 250 caracteres")
    private String familiarComDoencasDentarias;

    @Size(message = "Participação em programas preventivos deve ter no máximo 1 caractere")
    private Character participacaoEmProgramasPreventivos;

    @Size(message = "O contato emergencial deve ter no máximo 15 caracteres")
    private String contatoEmergencial;
    private Character pesquisaSatisfacao;
    private LocalDate dataUltimaAtualizacao;
    private Character frequenciaConsultaPeriodica;
    private String sinalizacaoDeRisco;
    private String historicoDeViagem;
    private String historicoDeMudancasDeEndereco;
    private String preferenciaDeContato;
}
