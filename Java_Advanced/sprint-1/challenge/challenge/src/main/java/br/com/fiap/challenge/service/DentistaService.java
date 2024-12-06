package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Dentista;

import java.util.List;

public interface DentistaService {

    Dentista criar(Dentista dentista);
    Dentista buscarPorId(Long id);
    List<Dentista> buscarTodos();
    Dentista atualizar(Long id, Dentista dentista);
    void deletar(Long id);
}
