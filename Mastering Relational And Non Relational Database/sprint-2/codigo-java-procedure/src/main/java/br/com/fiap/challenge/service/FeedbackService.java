package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Feedback;

import java.util.List;

public interface FeedbackService {

    Feedback criar(Feedback feedback);
    Feedback buscarPorId(String id);
    List<Feedback> buscarTodos();
    Feedback atualizar(String id, Feedback feedback);
    void deletar(String id);
}
