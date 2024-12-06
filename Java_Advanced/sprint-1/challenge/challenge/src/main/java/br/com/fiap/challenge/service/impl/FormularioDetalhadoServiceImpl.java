package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.FormularioDetalhado;
import br.com.fiap.challenge.gateways.repository.FormularioDetalhadoRepository;
import br.com.fiap.challenge.service.FormularioDetalhadoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FormularioDetalhadoServiceImpl implements FormularioDetalhadoService {

    private final FormularioDetalhadoRepository formularioDetalhadoRepository;

    @Override
    public FormularioDetalhado criar(FormularioDetalhado formulario) {
        return formularioDetalhadoRepository.save(formulario);
    }

    @Override
    public FormularioDetalhado buscarPorId(Long id) {
        return formularioDetalhadoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Formulário Detalhado não encontrado"));
    }

    @Override
    public List<FormularioDetalhado> buscarTodos() {
        return formularioDetalhadoRepository.findAll();
    }

    @Override
    public FormularioDetalhado atualizar(Long id, FormularioDetalhado formulario) {
        if (formularioDetalhadoRepository.existsById(id)) {
            formulario.setIdFormulario(id); // Define o ID para garantir a atualização correta
            return formularioDetalhadoRepository.save(formulario);
        } else {
            throw new RuntimeException("Formulário Detalhado não encontrado");
        }
    }

    @Override
    public void deletar(Long id) {
        if (formularioDetalhadoRepository.existsById(id)) {
            formularioDetalhadoRepository.deleteById(id);
        } else {
            throw new RuntimeException("Formulário Detalhado não encontrado");
        }
    }
}
