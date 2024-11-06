package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Clinica;
import jakarta.transaction.Transactional;

import java.math.BigDecimal;
import java.util.List;

public interface ClinicaService {

    List<Clinica> buscarTodas();

    Clinica buscarPorId(String id);

    @Transactional
    Clinica criar(Clinica clinica);

    @Transactional
    Clinica atualizar(String id, Clinica clinica);

    @Transactional
    void deletar(String id);
}
