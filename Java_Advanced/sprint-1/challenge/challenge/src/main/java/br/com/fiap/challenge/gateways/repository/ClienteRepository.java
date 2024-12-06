package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {
}
