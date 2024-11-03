package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Clinica;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClinicaRepository extends JpaRepository<Clinica, String> {
}
