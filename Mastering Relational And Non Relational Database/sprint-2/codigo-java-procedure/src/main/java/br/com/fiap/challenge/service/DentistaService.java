package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Dentista;

import java.util.List;

public interface DentistaService {

    Dentista criar(Dentista dentista);
    Dentista buscarPorId(String id);
    List<Dentista> buscarTodos();
    Dentista atualizar(String id, Dentista dentista);
    void deletar(String id);
}
