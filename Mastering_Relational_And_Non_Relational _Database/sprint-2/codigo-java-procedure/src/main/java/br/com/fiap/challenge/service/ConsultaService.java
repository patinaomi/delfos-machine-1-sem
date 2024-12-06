package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Consulta;

import java.util.List;

public interface ConsultaService {

    Consulta criar(Consulta consulta);
    Consulta buscarPorId(String id);
    List<Consulta> buscarTodas();
    Consulta atualizar(String id, Consulta consulta);
    void deletar(String id);
}
