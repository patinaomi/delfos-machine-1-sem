package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.request.ClienteRequest;
import br.com.fiap.challenge.gateways.request.ClienteUpdateRequest;
import br.com.fiap.challenge.gateways.response.ClienteResponse;
import br.com.fiap.challenge.service.ClienteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/clientes", produces = "application/json")
@RequiredArgsConstructor
@Tag(name = "cliente", description = "Operações relacionadas a clientes")
public class ClienteController {

    private final ClienteService clienteService;

    @Operation(
            summary = "Cria um novo cliente",
            description = "Cria um novo cliente com base nos dados informados"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Cliente criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = ClienteResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody ClienteRequest clienteRequest) {
        try {
            Cliente cliente = Cliente.builder()
                    .nome(clienteRequest.getNome())
                    .sobrenome(clienteRequest.getSobrenome())
                    .email(clienteRequest.getEmail())
                    .telefone(clienteRequest.getTelefone())
                    .dataNasc(clienteRequest.getDataNasc())
                    .endereco(clienteRequest.getEndereco())
                    .build();

            Cliente clienteSalvo = clienteService.criar(cliente);

            ClienteResponse clienteResponse = ClienteResponse.builder()
                    .nome(clienteSalvo.getNome())
                    .sobrenome(clienteSalvo.getSobrenome())
                    .email(clienteSalvo.getEmail())
                    .telefone(clienteSalvo.getTelefone())
                    .dataNasc(clienteSalvo.getDataNasc())
                    .endereco(clienteSalvo.getEndereco())
                    .build();

            return ResponseEntity.status(HttpStatus.CREATED).body(clienteResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar o cliente: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todos os clientes", description = "Retorna uma lista de todos os clientes")
    @GetMapping
    public ResponseEntity<?> buscarTodos() {
        try {
            List<Cliente> clientes = clienteService.buscarTodos();
            if (clientes.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum cliente encontrado.");
            }
            return ResponseEntity.ok(clientes);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar clientes: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar cliente por ID", description = "Retorna um cliente com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            Cliente cliente = clienteService.buscarPorId(id);
            return ResponseEntity.ok(cliente);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar cliente: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar cliente", description = "Atualiza os dados de um cliente com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable Long id, @Valid @RequestBody ClienteRequest clienteRequest) {
        try {
            Cliente cliente = Cliente.builder()
                    .nome(clienteRequest.getNome())
                    .sobrenome(clienteRequest.getSobrenome())
                    .email(clienteRequest.getEmail())
                    .telefone(clienteRequest.getTelefone())
                    .dataNasc(clienteRequest.getDataNasc())
                    .endereco(clienteRequest.getEndereco())
                    .build();

            Cliente clienteAtualizado = clienteService.atualizar(id, cliente);
            return ResponseEntity.ok(clienteAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar cliente: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar cliente", description = "Deleta um cliente com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable Long id) {
        try {
            clienteService.deletar(id);
            return ResponseEntity.ok("Cliente com ID " + id + " foi deletado com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar cliente: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos do cliente", description = "Atualiza campos específicos de um cliente com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Cliente atualizado com sucesso"),
            @ApiResponse(responseCode = "404", description = "Cliente não encontrado"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })

    public ResponseEntity<?> atualizarParcialmente(@PathVariable Long id, @RequestBody ClienteUpdateRequest clienteUpdateRequest) {
        try {
            Cliente cliente = clienteService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos que forem fornecidos no request
            if (clienteUpdateRequest.getNome() != null) {
                cliente.setNome(clienteUpdateRequest.getNome());
            }
            if (clienteUpdateRequest.getSobrenome() != null) {
                cliente.setSobrenome(clienteUpdateRequest.getSobrenome());
            }
            if (clienteUpdateRequest.getEmail() != null) {
                cliente.setEmail(clienteUpdateRequest.getEmail());
            }
            if (clienteUpdateRequest.getTelefone() != null) {
                cliente.setTelefone(clienteUpdateRequest.getTelefone());
            }
            if (clienteUpdateRequest.getDataNasc() != null) {
                cliente.setDataNasc(clienteUpdateRequest.getDataNasc());
            }
            if (clienteUpdateRequest.getEndereco() != null) {
                cliente.setEndereco(clienteUpdateRequest.getEndereco());
            }

            Cliente clienteAtualizado = clienteService.atualizar(id, cliente);
            return ResponseEntity.ok(clienteAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar cliente: " + e.getMessage());
        }
    }

}
