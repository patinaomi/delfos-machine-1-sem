package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Sinistro;

import java.util.List;

public interface SinistroService {

    Sinistro criar(Sinistro sinistro);
    Sinistro buscarPorId(Long id);
    List<Sinistro> buscarTodos();
    Sinistro atualizar(Long id, Sinistro sinistro);
    void deletar(Long id);

}
