package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.FormularioDetalhado;

import java.util.List;

public interface FormularioDetalhadoService {

    FormularioDetalhado criar(FormularioDetalhado formulario);
    FormularioDetalhado buscarPorId(Long id);
    List<FormularioDetalhado> buscarTodos();
    FormularioDetalhado atualizar(Long id, FormularioDetalhado formulario);
    void deletar(Long id);

}
