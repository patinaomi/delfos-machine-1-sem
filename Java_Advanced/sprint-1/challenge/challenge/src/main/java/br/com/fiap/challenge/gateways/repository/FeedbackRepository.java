package br.com.fiap.challenge.gateways.repository;

import br.com.fiap.challenge.domains.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
}
