package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Sinistro;
import br.com.fiap.challenge.gateways.repository.SinistroRepository;
import br.com.fiap.challenge.service.SinistroService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SinistroServiceImpl implements SinistroService {

    private final SinistroRepository sinistroRepository;

    @Override
    public Sinistro criar(Sinistro sinistro) {
        return sinistroRepository.save(sinistro);
    }

    @Override
    public Sinistro buscarPorId(String id) {
        return sinistroRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Sinistro não encontrado"));
    }

    @Override
    public List<Sinistro> buscarTodos() {
        return sinistroRepository.findAll();
    }

    @Override
    public Sinistro atualizar(String id, Sinistro sinistro) {
        if (sinistroRepository.existsById(id)) {
            sinistro.setIdSinistro(id);
            return sinistroRepository.save(sinistro);
        } else {
            throw new RuntimeException("Sinistro não encontrado");
        }
    }

    @Override
    public void deletar(String id) {
        if (sinistroRepository.existsById(id)) {
            sinistroRepository.deleteById(id);
        } else {
            throw new RuntimeException("Sinistro não encontrado");
        }
    }
}
