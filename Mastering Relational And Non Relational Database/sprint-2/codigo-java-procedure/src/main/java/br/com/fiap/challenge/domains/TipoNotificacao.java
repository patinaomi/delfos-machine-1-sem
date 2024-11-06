package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Entity
@Table(name = "tipo_notificacao")
public class TipoNotificacao {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_tipo_notificacao", nullable = false)
    private String idTipoNotificacao;

    @Column(name = "descricao", length = 40, nullable = false)
    private String descricao;
}
