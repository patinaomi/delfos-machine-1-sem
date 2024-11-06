package br.com.fiap.challenge.gateways.controller.repository;

import br.com.fiap.challenge.domains.EstadoCivil;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EstadoCivilRepository extends JpaRepository<EstadoCivil, String> {
}
