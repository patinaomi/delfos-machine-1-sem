package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Sinistro;

import java.util.List;

public interface SinistroService {

    Sinistro criar(Sinistro sinistro);
    Sinistro buscarPorId(String id);
    List<Sinistro> buscarTodos();
    Sinistro atualizar(String id, Sinistro sinistro);
    void deletar(String id);

}
