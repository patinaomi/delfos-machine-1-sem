package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Cliente;

import java.time.LocalDate;

public interface AuthenticationService {

    public Cliente findByEmailAndDateOfBirth(String email, LocalDate dataNasc);

    public Cliente authenticate(String email, String senha);

    public boolean updatePassword(String clienteId, String novaSenha);

    public Cliente findByEmail(String email);
}
