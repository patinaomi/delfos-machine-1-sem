package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Sinistro;
import br.com.fiap.challenge.gateways.request.SinistroRequest;
import br.com.fiap.challenge.gateways.request.SinistroUpdateRequest;
import br.com.fiap.challenge.gateways.response.SinistroResponse;
import br.com.fiap.challenge.service.SinistroService;
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
@RequestMapping("/sinistros")
@RequiredArgsConstructor
@Tag(name = "sinistro", description = "Operações relacionadas a sinistros")
public class SinistroController {

    private final SinistroService sinistroService;

    @Operation(summary = "Cria um novo sinistro", description = "Cria um novo sinistro com base nos dados informados")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Sinistro criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = SinistroResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody SinistroRequest sinistroRequest) {
        try {
            Sinistro sinistro = Sinistro.builder()
                    .consulta(sinistroRequest.getConsulta())
                    .nome(sinistroRequest.getNome())
                    .descricao(sinistroRequest.getDescricao())
                    .statusSinistro(sinistroRequest.getStatusSinistro())
                    .descricaoStatus(sinistroRequest.getDescricaoStatus())
                    .valorSinistro(sinistroRequest.getValorSinistro())
                    .dataAbertura(sinistroRequest.getDataAbertura())
                    .dataResolucao(sinistroRequest.getDataResolucao())
                    .documentacao(sinistroRequest.getDocumentacao())
                    .build();

            Sinistro sinistroSalvo = sinistroService.criar(sinistro);

            SinistroResponse sinistroResponse = SinistroResponse.builder()
                    .idSinistro(sinistroSalvo.getIdSinistro())
                    .consulta(sinistroSalvo.getConsulta())
                    .nome(sinistroSalvo.getNome())
                    .descricao(sinistroSalvo.getDescricao())
                    .statusSinistro(sinistroSalvo.getStatusSinistro())
                    .descricaoStatus(sinistroSalvo.getDescricaoStatus())
                    .valorSinistro(sinistroSalvo.getValorSinistro())
                    .dataAbertura(sinistroSalvo.getDataAbertura())
                    .dataResolucao(sinistroSalvo.getDataResolucao())
                    .documentacao(sinistroSalvo.getDocumentacao())
                    .build();

            return ResponseEntity.status(HttpStatus.CREATED).body(sinistroResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar o sinistro: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todos os sinistros", description = "Retorna uma lista de todos os sinistros")
    @GetMapping
    public ResponseEntity<?> buscarTodos() {
        try {
            List<Sinistro> sinistros = sinistroService.buscarTodos();
            if (sinistros.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum sinistro encontrado.");
            }
            return ResponseEntity.ok(sinistros);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar sinistros: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar sinistro por ID", description = "Retorna um sinistro com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            Sinistro sinistro = sinistroService.buscarPorId(id);
            return ResponseEntity.ok(sinistro);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sinistro com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar sinistro: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar sinistro", description = "Atualiza os dados de um sinistro com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable Long id, @Valid @RequestBody SinistroRequest sinistroRequest) {
        try {
            Sinistro sinistro = Sinistro.builder()
                    .consulta(sinistroRequest.getConsulta())
                    .nome(sinistroRequest.getNome())
                    .descricao(sinistroRequest.getDescricao())
                    .statusSinistro(sinistroRequest.getStatusSinistro())
                    .descricaoStatus(sinistroRequest.getDescricaoStatus())
                    .valorSinistro(sinistroRequest.getValorSinistro())
                    .dataAbertura(sinistroRequest.getDataAbertura())
                    .dataResolucao(sinistroRequest.getDataResolucao())
                    .documentacao(sinistroRequest.getDocumentacao())
                    .build();

            Sinistro sinistroAtualizado = sinistroService.atualizar(id, sinistro);
            return ResponseEntity.ok(sinistroAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sinistro com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar sinistro: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar sinistro", description = "Deleta um sinistro com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable Long id) {
        try {
            sinistroService.deletar(id);
            return ResponseEntity.ok("Sinistro com ID " + id + " foi deletado com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sinistro com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar sinistro: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos do sinistro", description = "Atualiza campos específicos de um sinistro com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Sinistro atualizado com sucesso"),
            @ApiResponse(responseCode = "404", description = "Sinistro não encontrado"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })
    public ResponseEntity<?> atualizarParcialmente(@PathVariable Long id, @RequestBody SinistroUpdateRequest sinistroUpdateRequest) {
        try {
            Sinistro sinistro = sinistroService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos no request
            if (sinistroUpdateRequest.getNome() != null) {
                sinistro.setNome(sinistroUpdateRequest.getNome());
            }
            if (sinistroUpdateRequest.getDescricao() != null) {
                sinistro.setDescricao(sinistroUpdateRequest.getDescricao());
            }
            if (sinistroUpdateRequest.getStatusSinistro() != null) {
                sinistro.setStatusSinistro(sinistroUpdateRequest.getStatusSinistro());
            }
            if (sinistroUpdateRequest.getDescricaoStatus() != null) {
                sinistro.setDescricaoStatus(sinistroUpdateRequest.getDescricaoStatus());
            }
            if (sinistroUpdateRequest.getValorSinistro() != null) {
                sinistro.setValorSinistro(sinistroUpdateRequest.getValorSinistro());
            }
            if (sinistroUpdateRequest.getDataAbertura() != null) {
                sinistro.setDataAbertura(sinistroUpdateRequest.getDataAbertura());
            }
            if (sinistroUpdateRequest.getDataResolucao() != null) {
                sinistro.setDataResolucao(sinistroUpdateRequest.getDataResolucao());
            }
            if (sinistroUpdateRequest.getDocumentacao() != null) {
                sinistro.setDocumentacao(sinistroUpdateRequest.getDocumentacao());
            }

            Sinistro sinistroAtualizado = sinistroService.atualizar(id, sinistro);
            return ResponseEntity.ok(sinistroAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sinistro com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar sinistro: " + e.getMessage());
        }
    }
}
