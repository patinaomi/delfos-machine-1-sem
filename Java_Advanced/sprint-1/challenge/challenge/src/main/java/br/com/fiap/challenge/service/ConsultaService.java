package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Consulta;

import java.util.List;

public interface ConsultaService {
    Consulta criar(Consulta consulta);
    Consulta buscarPorId(Long id);
    List<Consulta> buscarTodas();
    Consulta atualizar(Long id, Consulta consulta);
    void deletar(Long id);
}
