package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.gateways.request.ClinicaRequest;
import br.com.fiap.challenge.gateways.response.ClinicaResponse;
import br.com.fiap.challenge.service.ClinicaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.hateoas.Link;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/clinicas", produces = "application/json")
@RequiredArgsConstructor
@Tag(name = "clinica", description = "Operações relacionadas a clínicas")
public class ClinicaController {

    private final ClinicaService clinicaService;

    @Operation(
            summary = "Cria uma nova clínica",
            description = "Cria uma nova clínica com base nos dados informados"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Clínica criada com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = ClinicaResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody ClinicaRequest clinicaRequest) {
        try {
            Clinica clinica = Clinica.builder()
                    .nome(clinicaRequest.getNome())
                    .endereco(clinicaRequest.getEndereco())
                    .telefone(clinicaRequest.getTelefone())
                    .avaliacao(clinicaRequest.getAvaliacao())
                    .precoMedio(clinicaRequest.getPrecoMedio())
                    .build();

            Clinica clinicaSalva = clinicaService.criar(clinica);

            ClinicaResponse clinicaResponse = ClinicaResponse.builder()
                    .nome(clinicaSalva.getNome())
                    .endereco(clinicaSalva.getEndereco())
                    .telefone(clinicaSalva.getTelefone())
                    .avaliacao(clinicaSalva.getAvaliacao())
                    .precoMedio(clinicaSalva.getPrecoMedio())
                    .build();

            Link link = linkTo(methodOn(ClinicaController.class).buscarPorId(clinicaSalva.getIdClinica())).withSelfRel();
            clinicaResponse.add(link);

            return ResponseEntity.status(HttpStatus.CREATED).body(clinicaResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar a clínica: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todas as clínicas", description = "Retorna uma lista de todas as clínicas")
    @GetMapping
    public ResponseEntity<?> buscarTodas() {
        try {
            List<Clinica> clinicas = clinicaService.buscarTodas();

            List<ClinicaResponse> clinicaResponses = clinicas.stream().map(clinica -> {
                ClinicaResponse response = ClinicaResponse.builder()
                        .nome(clinica.getNome())
                        .endereco(clinica.getEndereco())
                        .telefone(clinica.getTelefone())
                        .avaliacao(clinica.getAvaliacao())
                        .precoMedio(clinica.getPrecoMedio())
                        .build();
                Link link = linkTo(methodOn(ClinicaController.class).buscarPorId(clinica.getIdClinica())).withSelfRel();
                response.add(link);
                return response;
            }).collect(Collectors.toList());

            return ResponseEntity.ok(clinicaResponses);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar clínicas: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar clínica por ID", description = "Retorna uma clínica com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            Clinica clinica = clinicaService.buscarPorId(id);
            ClinicaResponse clinicaResponse = ClinicaResponse.builder()
                    .nome(clinica.getNome())
                    .endereco(clinica.getEndereco())
                    .telefone(clinica.getTelefone())
                    .avaliacao(clinica.getAvaliacao())
                    .precoMedio(clinica.getPrecoMedio())
                    .build();

            clinicaResponse.add(linkTo(methodOn(ClinicaController.class).buscarPorId(id)).withSelfRel());
            return ResponseEntity.ok(clinicaResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Clínica com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar clínica: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar clínica", description = "Atualiza os dados de uma clínica com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable String id, @Valid @RequestBody ClinicaRequest clinicaRequest) {
        try {
            Clinica clinica = Clinica.builder()
                    .nome(clinicaRequest.getNome())
                    .endereco(clinicaRequest.getEndereco())
                    .telefone(clinicaRequest.getTelefone())
                    .avaliacao(clinicaRequest.getAvaliacao())
                    .precoMedio(clinicaRequest.getPrecoMedio())
                    .build();

            Clinica clinicaAtualizada = clinicaService.atualizar(id, clinica);

            ClinicaResponse clinicaResponse = ClinicaResponse.builder()
                    .nome(clinicaAtualizada.getNome())
                    .endereco(clinicaAtualizada.getEndereco())
                    .telefone(clinicaAtualizada.getTelefone())
                    .avaliacao(clinicaAtualizada.getAvaliacao())
                    .precoMedio(clinicaAtualizada.getPrecoMedio())
                    .build();

            Link link = linkTo(methodOn(ClinicaController.class).buscarPorId(id)).withSelfRel();
            clinicaResponse.add(link);

            return ResponseEntity.ok(clinicaResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Clínica com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar clínica: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar clínica", description = "Deleta uma clínica com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable String id) {
        try {
            clinicaService.deletar(id);
            return ResponseEntity.ok("Clínica com ID " + id + " foi deletada com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Clínica com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar clínica: " + e.getMessage());
        }
    }
}
