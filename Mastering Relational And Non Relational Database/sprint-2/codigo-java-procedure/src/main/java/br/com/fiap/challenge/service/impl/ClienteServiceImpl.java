package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.controller.repository.ClienteRepository;
import br.com.fiap.challenge.service.ClienteService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import jakarta.persistence.StoredProcedureQuery;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteServiceImpl implements ClienteService {

    private final ClienteRepository clienteRepository;
    private final EmailServiceImpl emailService;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void atualizarCliente(String idCliente, String nome, String sobrenome, String email,
                                 String telefone, LocalDate dataNasc, String endereco) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("atualizar_cliente");

        // Registrar parâmetros de entrada para a procedure
        query.registerStoredProcedureParameter("p_id_cliente", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_nome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_sobrenome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_email", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_telefone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_data_nasc", java.sql.Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_endereco", String.class, ParameterMode.IN);

        // Definir os valores dos parâmetros
        query.setParameter("p_id_cliente", idCliente);
        query.setParameter("p_nome", nome);
        query.setParameter("p_sobrenome", sobrenome);
        query.setParameter("p_email", email);
        query.setParameter("p_telefone", telefone);
        query.setParameter("p_data_nasc", dataNasc);
        query.setParameter("p_endereco", endereco);

        // Executar a procedure
        query.execute();
    }

    @Transactional
    public void inserirCliente(String nome, String sobrenome, String email,
                               String telefone, LocalDate dataNasc, String endereco) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("inserir_cliente");

        // Registrar parâmetros de entrada para a procedure
        query.registerStoredProcedureParameter("p_nome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_sobrenome", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_email", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_telefone", String.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_data_nasc", java.sql.Date.class, ParameterMode.IN);
        query.registerStoredProcedureParameter("p_endereco", String.class, ParameterMode.IN);

        // Definir os valores dos parâmetros
        query.setParameter("p_nome", nome);
        query.setParameter("p_sobrenome", sobrenome);
        query.setParameter("p_email", email);
        query.setParameter("p_telefone", telefone);
        query.setParameter("p_data_nasc", dataNasc);
        query.setParameter("p_endereco", endereco);

        // Executar a procedure
        query.execute();
    }

    @Transactional
    public void deletarCliente(String idCliente) {
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("deletar_cliente");

        // Registrar o parâmetro de entrada para a procedure no Oracle
        query.registerStoredProcedureParameter("p_id_cliente", String.class, ParameterMode.IN);

        // Definir o valor do parâmetro
        query.setParameter("p_id_cliente", idCliente);

        // Executar a procedure
        query.execute();
    }



    @Override
    public Cliente criar(Cliente cliente) {
        cliente.setTelefone(limparCaracteresTel(cliente.getTelefone()));
        Cliente clienteSalvo = clienteRepository.save(cliente);

        String mensagemEmail = String.format(
                "Olá, %s! Seu cadastro foi realizado com sucesso!",
                cliente.getNome()
        );

        emailService.enviarEmail(cliente.getEmail(), "Cadastro Realizado", mensagemEmail);
        return clienteSalvo;
    }

    @Override
    public Cliente buscarPorId(String id) {
        return clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
    }

    @Override
    public List<Cliente> buscarTodos() {
        return clienteRepository.findAll();
    }

    @Override
    public Cliente atualizar(String id, Cliente cliente) {
        if (clienteRepository.existsById(id)) {
            cliente.setIdCliente(id);
            cliente.setTelefone(limparCaracteresTel(cliente.getTelefone())); // Limpeza do telefone antes de atualizar
            return clienteRepository.save(cliente);
        } else {
            throw new RuntimeException("Cliente não encontrado");
        }
    }

    @Override
    public void deletar(String id) {
        if (clienteRepository.existsById(id)) {
            clienteRepository.deleteById(id);
        } else {
            throw new RuntimeException("Cliente não encontrado");
        }
    }

    // Método utilitário para limpar caracteres não numéricos do telefone
    private String limparCaracteresTel(String telefone) {
        return telefone != null ? telefone.replaceAll("\\D", "") : null;
    }
}
