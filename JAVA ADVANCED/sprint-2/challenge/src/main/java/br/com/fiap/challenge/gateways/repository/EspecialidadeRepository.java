package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Especialidade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EspecialidadeRepository extends JpaRepository<Especialidade, String> {
}
