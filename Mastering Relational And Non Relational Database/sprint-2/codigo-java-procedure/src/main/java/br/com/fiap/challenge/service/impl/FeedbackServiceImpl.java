package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Feedback;
import br.com.fiap.challenge.gateways.controller.repository.FeedbackRepository;
import br.com.fiap.challenge.service.FeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;

    @Override
    public Feedback criar(Feedback feedback) {
        return feedbackRepository.save(feedback);
    }

    @Override
    public Feedback buscarPorId(String id) {
        return feedbackRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Feedback não encontrado"));
    }

    @Override
    public List<Feedback> buscarTodos() {
        return feedbackRepository.findAll();
    }

    @Override
    public Feedback atualizar(String id, Feedback feedback) {
        if (feedbackRepository.existsById(id)) {
            feedback.setIdFeedback(id);
            return feedbackRepository.save(feedback);
        } else {
            throw new RuntimeException("Feedback não encontrado");
        }
    }

    @Override
    public void deletar(String id) {
        if (feedbackRepository.existsById(id)) {
            feedbackRepository.deleteById(id);
        } else {
            throw new RuntimeException("Feedback não encontrado");
        }
    }
}
