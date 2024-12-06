package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.repository.ClienteRepository;
import br.com.fiap.challenge.service.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements AuthenticationService {

    private final ClienteRepository clienteRepository;

    public Cliente findByEmailAndDateOfBirth(String email, LocalDate dataNasc) {
        return clienteRepository.findByEmailAndDataNasc(email, dataNasc);
    }

    public Cliente authenticate(String email, String senha) {
        Cliente cliente = clienteRepository.findByEmail(email);
        if(cliente != null && cliente.getSenha().equals(senha)) {
            return cliente;
        }
        return null;
    }

    public boolean updatePassword(String clienteId, String novaSenha) {
        Optional<Cliente> clienteOptional = clienteRepository.findById(clienteId);

        if (clienteOptional.isPresent()) {
            Cliente cliente = clienteOptional.get();
            cliente.setSenha(novaSenha);
            clienteRepository.save(cliente);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Cliente findByEmail(String email) {
        return clienteRepository.findByEmail(email);
    }
}
