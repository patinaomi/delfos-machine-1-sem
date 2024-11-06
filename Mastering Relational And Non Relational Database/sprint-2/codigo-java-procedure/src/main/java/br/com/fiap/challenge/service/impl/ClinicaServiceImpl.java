package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.gateways.controller.repository.ClinicaRepository;
import br.com.fiap.challenge.service.ClinicaService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClinicaServiceImpl implements ClinicaService {

    private final ClinicaRepository clinicaRepository;

    @PersistenceContext
    private EntityManager entityManager;

    // Método para buscar todas as clínicas
    @Override
    public List<Clinica> buscarTodas() {
        return clinicaRepository.findAll();
    }

    // Método para buscar clínica por ID
    @Override
    public Clinica buscarPorId(String id) {
        return clinicaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Clínica não encontrada"));
    }

    // Método para inserir uma nova clínica usando Stored Procedure
    @Override
    @Transactional
    public Clinica criar(Clinica clinica) {
        // Usando a Stored Procedure para inserir a clínica
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("inserir_clinica");
        query.registerStoredProcedureParameter("p_nome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_endereco", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_telefone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_avaliacao", Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_preco_medio", Double.class, ParameterMode.IN);

        query.setParameter("p_nome", clinica.getNome());
        query.setParameter("p_endereco", clinica.getEndereco());
        query.setParameter("p_telefone", clinica.getTelefone());
        query.setParameter("p_avaliacao", clinica.getAvaliacao());
        query.setParameter("p_preco_medio", clinica.getPrecoMedio());

        query.execute();

        // Salva a clínica usando o repositório após a execução da Stored Procedure
        return clinicaRepository.save(clinica);
    }

    // Método para atualizar uma clínica usando Stored Procedure
    @Override
    @Transactional
    public Clinica atualizar(String id, Clinica clinica) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("atualizar_clinica");
        query.registerStoredProcedureParameter("p_id_clinica", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_nome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_endereco", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_telefone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_avaliacao", Double.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_preco_medio", Double.class, ParameterMode.IN);

        query.setParameter("p_id_clinica", id);
        query.setParameter("p_nome", clinica.getNome());
        query.setParameter("p_endereco", clinica.getEndereco());
        query.setParameter("p_telefone", clinica.getTelefone());
        query.setParameter("p_avaliacao", clinica.getAvaliacao());
        query.setParameter("p_preco_medio", clinica.getPrecoMedio());

        query.execute();

        // Salva a clínica atualizada
        clinica.setIdClinica(id);
        return clinicaRepository.save(clinica);
    }

    // Método para deletar uma clínica usando Stored Procedure
    @Override
    @Transactional
    public void deletar(String id) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("deletar_clinica");
        query.registerStoredProcedureParameter("p_id_clinica", String.class, ParameterMode.IN);

        query.setParameter("p_id_clinica", id);
        query.execute();

        // Remove a clínica do repositório após a execução da Stored Procedure
        clinicaRepository.deleteById(id);
    }
}
