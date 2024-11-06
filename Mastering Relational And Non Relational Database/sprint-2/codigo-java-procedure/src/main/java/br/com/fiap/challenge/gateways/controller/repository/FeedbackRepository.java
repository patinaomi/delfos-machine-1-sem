package br.com.fiap.challenge.gateways.controller.repository;

import br.com.fiap.challenge.domains.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackRepository extends JpaRepository<Feedback, String> {
}
