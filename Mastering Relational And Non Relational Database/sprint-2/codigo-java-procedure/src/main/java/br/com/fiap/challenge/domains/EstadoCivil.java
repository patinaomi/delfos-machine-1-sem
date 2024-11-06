package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "estado_civil")
public class EstadoCivil {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_estado_civil", nullable = false)
    private String idEstadoCivil;

    @Column(name = "descricao", length = 50, nullable = false)
    private String descricao;

}
