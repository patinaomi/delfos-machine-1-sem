package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Dentista;
import br.com.fiap.challenge.gateways.controller.repository.DentistaRepository;
import br.com.fiap.challenge.service.DentistaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DentistaServiceImpl implements DentistaService {

    private final DentistaRepository dentistaRepository;

    @Override
    public Dentista criar(Dentista dentista) {
        dentista.setTelefone(limparCaracteresTel(dentista.getTelefone()));
        return dentistaRepository.save(dentista);
    }

    @Override
    public Dentista buscarPorId(String id) {
        return dentistaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));
    }

    @Override
    public List<Dentista> buscarTodos() {
        return dentistaRepository.findAll();
    }

    @Override
    public Dentista atualizar(String id, Dentista dentista) {
        if (dentistaRepository.existsById(id)) {
            dentista.setIdDentista(id);
            return dentistaRepository.save(dentista);
        } else {
            throw new RuntimeException("Dentista não encontrado");
        }
    }

    @Override
    public void deletar(String id) {
        if (dentistaRepository.existsById(id)) {
            dentistaRepository.deleteById(id);
        } else {
            throw new RuntimeException("Dentista não encontrado");
        }
    }

    // Método utilitário para limpar caracteres não numéricos do telefone
    private String limparCaracteresTel(String telefone) {
        return telefone != null ? telefone.replaceAll("\\D", "") : null;
    }
}
