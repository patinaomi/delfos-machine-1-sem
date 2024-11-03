package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.EstadoCivil;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class FormularioDetalhadoRequest extends RepresentationModel<FormularioDetalhadoRequest> {

    @NotNull(message = "Cliente não pode ser nulo")
    private String cliente;

    @NotNull(message = "Estado civil não pode ser nulo")
    private String estadoCivil;

    @Size(max = 250, message = "O histórico familiar deve ter no máximo 250 caracteres")
    private String historicoFamiliar;

    @Size(max = 100, message = "A profissão deve ter no máximo 100 caracteres")
    private String profissao;

    private Double rendaMensal;

    @Size(max = 250, message = "O histórico médico deve ter no máximo 250 caracteres")
    private String historicoMedico;

    @Size(max = 250, message = "Alergia deve ter no máximo 250 caracteres")
    private String alergia;

    @Size(max = 250, message = "A medicação deve ter no máximo 250 caracteres")
    private String condicaoPreexistente;

    @Size(max = 250, message = "O uso de medicamento deve ter no máximo 250 caracteres")
    private String usoMedicamento;

    @Size(max = 255, message = "O histórico odontológico deve ter no máximo 255 caracteres")
    private String familiarComDoencasDentarias;

    private Character participacaoEmProgramasPreventivos;

    @Size(max = 15, message = "O contato emergencial deve ter no máximo 15 caracteres")
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

    @Size(max = 250, message = "A preferência de contato deve ter no máximo 250 caracteres")
    private String preferenciaDeContato;
}
