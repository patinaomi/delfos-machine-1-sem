package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Dentista;
import br.com.fiap.challenge.gateways.request.DentistaRequest;
import br.com.fiap.challenge.gateways.request.DentistaUpdateRequest;
import br.com.fiap.challenge.gateways.response.DentistaResponse;
import br.com.fiap.challenge.service.DentistaService;
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
@RequestMapping("/dentistas")
@RequiredArgsConstructor
@Tag(name = "dentista", description = "Operações relacionadas a dentistas")
public class DentistaController {

    private final DentistaService dentistaService;

    @Operation(summary = "Cria um novo dentista", description = "Cria um novo dentista com base nos dados informados")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Dentista criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = DentistaResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody DentistaRequest dentistaRequest) {
        try {
            Dentista dentista = Dentista.builder()
                    .nome(dentistaRequest.getNome())
                    .sobrenome(dentistaRequest.getSobrenome())
                    .telefone(dentistaRequest.getTelefone())
                    .clinica(dentistaRequest.getClinica())
                    .especialidade(dentistaRequest.getEspecialidade())
                    .avaliacao(dentistaRequest.getAvaliacao())
                    .build();

            Dentista dentistaSalvo = dentistaService.criar(dentista);

            DentistaResponse dentistaResponse = DentistaResponse.builder()
                    .idDentista(dentistaSalvo.getIdDentista())
                    .nome(dentistaSalvo.getNome())
                    .sobrenome(dentistaSalvo.getSobrenome())
                    .telefone(dentistaSalvo.getTelefone())
                    .clinica(dentistaSalvo.getClinica())
                    .especialidade(dentistaSalvo.getEspecialidade())
                    .avaliacao(dentistaSalvo.getAvaliacao())
                    .build();

            return ResponseEntity.status(HttpStatus.CREATED).body(dentistaResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar o dentista: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todos os dentistas", description = "Retorna uma lista de todos os dentistas")
    @GetMapping
    public ResponseEntity<?> buscarTodos() {
        try {
            List<Dentista> dentistas = dentistaService.buscarTodos();
            if (dentistas.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum dentista encontrado.");
            }
            return ResponseEntity.ok(dentistas);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar dentistas: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar dentista por ID", description = "Retorna um dentista com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            Dentista dentista = dentistaService.buscarPorId(id);
            return ResponseEntity.ok(dentista);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Dentista com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar dentista: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar dentista", description = "Atualiza os dados de um dentista com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable Long id, @Valid @RequestBody DentistaRequest dentistaRequest) {
        try {
            Dentista dentista = Dentista.builder()
                    .nome(dentistaRequest.getNome())
                    .sobrenome(dentistaRequest.getSobrenome())
                    .telefone(dentistaRequest.getTelefone())
                    .clinica(dentistaRequest.getClinica())
                    .especialidade(dentistaRequest.getEspecialidade())
                    .avaliacao(dentistaRequest.getAvaliacao())
                    .build();

            Dentista dentistaAtualizado = dentistaService.atualizar(id, dentista);
            return ResponseEntity.ok(dentistaAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Dentista com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar dentista: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar dentista", description = "Deleta um dentista com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable Long id) {
        try {
            dentistaService.deletar(id);
            return ResponseEntity.ok("Dentista com ID " + id + " foi deletado com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Dentista com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar dentista: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos do dentista", description = "Atualiza campos específicos de um dentista com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dentista atualizado com sucesso"),
            @ApiResponse(responseCode = "404", description = "Dentista não encontrado"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })
    public ResponseEntity<?> atualizarParcialmente(@PathVariable Long id, @RequestBody DentistaUpdateRequest dentistaUpdateRequest) {
        try {
            Dentista dentista = dentistaService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos no request
            if (dentistaUpdateRequest.getNome() != null) {
                dentista.setNome(dentistaUpdateRequest.getNome());
            }
            if (dentistaUpdateRequest.getSobrenome() != null) {
                dentista.setSobrenome(dentistaUpdateRequest.getSobrenome());
            }
            if (dentistaUpdateRequest.getTelefone() != null) {
                dentista.setTelefone(dentistaUpdateRequest.getTelefone());
            }
            if (dentistaUpdateRequest.getAvaliacao() != null) {
                dentista.setAvaliacao(dentistaUpdateRequest.getAvaliacao());
            }

            Dentista dentistaAtualizado = dentistaService.atualizar(id, dentista);
            return ResponseEntity.ok(dentistaAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Dentista com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar dentista: " + e.getMessage());
        }
    }

}
