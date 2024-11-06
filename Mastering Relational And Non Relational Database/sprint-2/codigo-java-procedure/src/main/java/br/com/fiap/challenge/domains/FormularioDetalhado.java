package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Entity
@Table(name = "formulario_detalhado")
public class FormularioDetalhado {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_formulario", nullable = false)
    private String idFormulario;

    @ManyToOne
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "id_estado_civil", nullable = false)
    private EstadoCivil estadoCivil;

    @Column(name = "historico_familiar", length = 250)
    private String historicoFamiliar;

    @Column(name = "profissao", length = 100)
    private String profissao;

    @Column(name = "renda_mensal")
    private Double rendaMensal;

    @Column(name = "historico_medico", length = 250)
    private String historicoMedico;

    @Column(name = "alergia", length = 250)
    private String alergia;

    @Column(name = "condicao_preexistente", length = 250)
    private String condicaoPreexistente;

    @Column(name = "uso_medicamento", length = 250)
    private String usoMedicamento;

    @Column(name = "familiar_com_doencas_dentarias", length = 255)
    private String familiarComDoencasDentarias;

    @Column(name = "participacao_em_programas_preventivos", length = 1)
    private Character participacaoEmProgramasPreventivos;

    @Column(name = "contato_emergencial", length = 250)
    private String contatoEmergencial;

    @Column(name = "pesquisa_satisfacao", length = 1)
    private Character pesquisaSatisfacao;

    @Column(name = "data_ultima_atualizacao")
    private LocalDate dataUltimaAtualizacao;

    @Column(name = "frequencia_consulta_periodica", length = 1)
    private Character frequenciaConsultaPeriodica;

    @Column(name = "sinalizacao_de_risco", length = 250)
    private String sinalizacaoDeRisco;

    @Column(name = "historico_de_viagem", length = 250)
    private String historicoDeViagem;

    @Column(name = "historico_de_mudancas_de_endereco", length = 250)
    private String historicoDeMudancasDeEndereco;

    @Column(name = "preferencia_de_contato", length = 50)
    private String preferenciaDeContato;

}
