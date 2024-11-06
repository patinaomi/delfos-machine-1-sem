package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Cliente;

import java.util.List;

public interface ClienteService {

    Cliente criar(Cliente cliente);
    Cliente buscarPorId(String id);
    List<Cliente> buscarTodos();
    Cliente atualizar(String id, Cliente cliente);
    void deletar(String id);

}
