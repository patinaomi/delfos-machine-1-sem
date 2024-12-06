package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.request.ClienteRequest;
import br.com.fiap.challenge.gateways.request.ClienteUpdateRequest;
import br.com.fiap.challenge.gateways.response.ClienteAuthResponse;
import br.com.fiap.challenge.gateways.response.ClienteResponse;
import br.com.fiap.challenge.service.ClienteService;
import br.com.fiap.challenge.service.impl.ClienteServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.Link;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;


import java.sql.Date;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping(value = "/clientes", produces = "application/json")
@RequiredArgsConstructor
@Tag(name = "cliente", description = "Operações relacionadas a clientes")
public class ClienteController {

    private final ClienteService clienteService;
    private final ClienteServiceImpl clienteServiceImpl;

    @GetMapping("/{clienteId}")
    public ResponseEntity<ClienteAuthResponse> getCliente(@PathVariable String clienteId) {

        Cliente cliente = clienteService.buscarPorId(clienteId);
        System.out.println(clienteId);
        if (cliente != null) {
            return ResponseEntity.ok(new ClienteAuthResponse(cliente.getNome()));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @Operation(summary = "Cria um novo cliente usando procedure", description = "Cria um novo cliente com base nos dados informados")
    @PostMapping("/criar-procedure")
    public ResponseEntity<?> criarProcedure(@Valid @RequestBody ClienteRequest clienteRequest) {
        try {
            clienteServiceImpl.inserirCliente(
                    clienteRequest.getNome(),
                    clienteRequest.getSobrenome(),
                    clienteRequest.getEmail(),
                    clienteRequest.getTelefone(),
                    clienteRequest.getDataNasc(),
                    clienteRequest.getEndereco()
            );
            return ResponseEntity.status(HttpStatus.CREATED).body("Cliente criado com sucesso via procedure.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar cliente via procedure: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualiza um cliente usando procedure", description = "Atualiza os dados de um cliente com base no ID fornecido")
    @PutMapping("/atualizar-procedure/{id}")
    public ResponseEntity<?> atualizarProcedure(
            @PathVariable String id,
            @Valid @RequestBody ClienteRequest clienteRequest) {
        try {
            clienteServiceImpl.atualizarCliente(
                    id,
                    clienteRequest.getNome(),
                    clienteRequest.getSobrenome(),
                    clienteRequest.getEmail(),
                    clienteRequest.getTelefone(),
                    clienteRequest.getDataNasc(),
                    clienteRequest.getEndereco()
            );
            return ResponseEntity.ok("Cliente atualizado com sucesso via procedure.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar cliente via procedure: " + e.getMessage());
        }
    }

    @Operation(summary = "Deleta um cliente usando procedure", description = "Deleta um cliente com base no ID fornecido usando procedure")
    @DeleteMapping("/deletar-procedure/{id}")
    public ResponseEntity<?> deletarProcedure(@PathVariable String id) {
        try {
            clienteServiceImpl.deletarCliente(id);
            return ResponseEntity.ok("Cliente deletado com sucesso via procedure.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar cliente via procedure: " + e.getMessage());
        }
    }
}
