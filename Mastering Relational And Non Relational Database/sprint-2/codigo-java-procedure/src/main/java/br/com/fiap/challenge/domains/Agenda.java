package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "agenda")
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_agenda", nullable = false)
    private String idAgenda;

    @ManyToOne
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "id_consulta", nullable = false)
    private Consulta consulta;

    @Column(name = "data_consulta", nullable = false)
    private Timestamp dataConsulta;

    @Column(name = "status_consulta", length = 1)
    private Character statusConsulta;

    @Column(name = "observacoes", length = 250)
    private String observacoes;

}
