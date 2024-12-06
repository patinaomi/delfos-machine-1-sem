package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Consulta;
import br.com.fiap.challenge.gateways.repository.ConsultaRepository;
import br.com.fiap.challenge.service.ConsultaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ConsultaServiceImpl implements ConsultaService {

    private final ConsultaRepository consultaRepository;

    @Override
    public Consulta criar(Consulta consulta) {
        return consultaRepository.save(consulta);
    }

    @Override
    public Consulta buscarPorId(Long id) {
        return consultaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Consulta não encontrada"));
    }

    @Override
    public List<Consulta> buscarTodas() {
        return consultaRepository.findAll();
    }

    @Override
    public Consulta atualizar(Long id, Consulta consulta) {
        if (consultaRepository.existsById(id)) {
            consulta.setIdConsulta(id);
            return consultaRepository.save(consulta);
        } else {
            throw new RuntimeException("Consulta não encontrada");
        }
    }

    @Override
    public void deletar(Long id) {
        if (consultaRepository.existsById(id)) {
            consultaRepository.deleteById(id);
        } else {
            throw new RuntimeException("Consulta não encontrada");
        }
    }
}
