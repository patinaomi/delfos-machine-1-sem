package br.com.fiap.challenge.gateways.controller.repository;

import br.com.fiap.challenge.domains.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ConsultaRepository extends JpaRepository<Consulta, String> {
}
