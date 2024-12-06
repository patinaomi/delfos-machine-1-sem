package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.FormularioDetalhado;

import java.util.List;

public interface FormularioDetalhadoService {

    FormularioDetalhado criar(FormularioDetalhado formulario);
    FormularioDetalhado buscarPorId(String id);
    List<FormularioDetalhado> buscarTodos();
    FormularioDetalhado atualizar(String id, FormularioDetalhado formulario);
    void deletar(String id);

}
