package br.com.fiap.challenge.gateways.controller.repository;

import br.com.fiap.challenge.domains.Dentista;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DentistaRepository extends JpaRepository<Dentista, String> {
}
