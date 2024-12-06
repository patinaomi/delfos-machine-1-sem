package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.request.LoginRequest;
import br.com.fiap.challenge.gateways.request.UpdatePasswordRequest;
import br.com.fiap.challenge.gateways.request.ValidateEmailRequest;
import br.com.fiap.challenge.gateways.request.ValidateUserRequest;
import br.com.fiap.challenge.gateways.response.*;
import br.com.fiap.challenge.service.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {

    private final AuthenticationService authenticationService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        Cliente cliente = authenticationService.authenticate(loginRequest.getEmail(), loginRequest.getSenha());
        if (cliente != null) {
            // Retorna um JSON de sucesso com o ID do cliente autenticado
            return ResponseEntity.ok(new LoginResponse("Login bem-sucedido", cliente.getIdCliente()));
        } else {
            // Retorna um JSON de erro com status 401
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse("Credenciais inválidas"));
        }
    }

    @PostMapping("/validate-user")
    public ResponseEntity<?> validateUser(@RequestBody ValidateUserRequest request) {
        Cliente cliente = authenticationService.findByEmailAndDateOfBirth(request.getEmail(), request.getDataNasc());
        if (cliente != null) {
            // Usuário validado com sucesso
            return ResponseEntity.ok(new MessageResponse("Usuário validado com sucesso"));
        } else {
            // E-mail ou data de nascimento incorretos
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponse("Usuário não encontrado ou dados incorretos"));
        }
    }

    @PostMapping("/update-password")
    public ResponseEntity<?> updatePassword(@RequestBody UpdatePasswordRequest request) {
        boolean isUpdated = authenticationService.updatePassword(request.getClienteId(), request.getNovaSenha());

        if (isUpdated) {
            return ResponseEntity.ok(new MessageResponse("Senha atualizada com sucesso"));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponse("Erro ao atualizar senha"));
        }
    }

    @PostMapping("/validate-email")
    public ResponseEntity<?> validateEmail(@RequestBody ValidateEmailRequest request) {
        Cliente cliente = authenticationService.findByEmail(request.getEmail());

        if (cliente != null) {
            boolean isValid = cliente.getEmail().equals(request.getEmail());
            return ResponseEntity.ok(new EmailResponse("E-mail encontrado", cliente.getEmail(), isValid));
        } else {
            boolean isValid = false;
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new EmailErrorResponse("E-mail não encontrado", isValid));
        }
    }
}

