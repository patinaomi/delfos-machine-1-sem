package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Data
@Builder
@Table(name = "clinica")
public class Clinica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_clinica", nullable = false)
    private Long idClinica;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "endereco", length = 250, nullable = false)
    private String endereco;

    @Column(name = "telefone", length = 15, nullable = false)
    private String telefone;

    @Column(name = "avaliacao")
    private Float avaliacao;

    @Column(name = "preco_medio")
    private Double precoMedio;

}
