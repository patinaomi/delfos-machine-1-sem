package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Consulta;
import br.com.fiap.challenge.gateways.request.ConsultaRequest;
import br.com.fiap.challenge.gateways.request.ConsultaUpdateRequest;
import br.com.fiap.challenge.gateways.response.ConsultaResponse;
import br.com.fiap.challenge.service.ConsultaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/consultas")
@RequiredArgsConstructor
@Tag(name = "consulta", description = "Operações relacionadas a consultas")
public class ConsultaController {

    private final ConsultaService consultaService;

    @Operation(summary = "Cria uma nova consulta", description = "Cria uma nova consulta com base nos dados informados")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Consulta criada com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = ConsultaResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody ConsultaRequest consultaRequest) {
        try {
            Consulta consulta = Consulta.builder()
                    .cliente(consultaRequest.getCliente())
                    .clinica(consultaRequest.getClinica())
                    .dentista(consultaRequest.getDentista())
                    .tipoServico(consultaRequest.getTipoServico())
                    .dataConsulta(consultaRequest.getDataConsulta())
                    .statusConsulta(consultaRequest.getStatusConsulta())
                    .observacoes(consultaRequest.getObservacoes())
                    .sintomas(consultaRequest.getSintomas())
                    .tratamentoRecomendado(consultaRequest.getTratamentoRecomendado())
                    .custo(consultaRequest.getCusto())
                    .prescricao(consultaRequest.getPrescricao())
                    .dataRetorno(consultaRequest.getDataRetorno())
                    .build();

            Consulta consultaSalva = consultaService.criar(consulta);

            ConsultaResponse consultaResponse = ConsultaResponse.builder()
                    .idConsulta(consultaSalva.getIdConsulta())
                    .cliente(consultaSalva.getCliente())
                    .clinica(consultaSalva.getClinica())
                    .dentista(consultaSalva.getDentista())
                    .tipoServico(consultaSalva.getTipoServico())
                    .dataConsulta(consultaSalva.getDataConsulta())
                    .statusConsulta(consultaSalva.getStatusConsulta())
                    .observacoes(consultaSalva.getObservacoes())
                    .sintomas(consultaSalva.getSintomas())
                    .tratamentoRecomendado(consultaSalva.getTratamentoRecomendado())
                    .custo(consultaSalva.getCusto())
                    .prescricao(consultaSalva.getPrescricao())
                    .dataRetorno(consultaSalva.getDataRetorno())
                    .build();

            return ResponseEntity.status(HttpStatus.CREATED).body(consultaResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar a consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todas as consultas", description = "Retorna uma lista de todas as consultas")
    @GetMapping
    public ResponseEntity<?> buscarTodas() {
        try {
            List<Consulta> consultas = consultaService.buscarTodas();
            if (consultas.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhuma consulta encontrada.");
            }
            return ResponseEntity.ok(consultas);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar consultas: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar consulta por ID", description = "Retorna uma consulta com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            Consulta consulta = consultaService.buscarPorId(id);
            return ResponseEntity.ok(consulta);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar consulta", description = "Atualiza os dados de uma consulta com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable Long id, @Valid @RequestBody ConsultaRequest consultaRequest) {
        try {
            Consulta consulta = Consulta.builder()
                    .cliente(consultaRequest.getCliente())
                    .clinica(consultaRequest.getClinica())
                    .dentista(consultaRequest.getDentista())
                    .tipoServico(consultaRequest.getTipoServico())
                    .dataConsulta(consultaRequest.getDataConsulta())
                    .statusConsulta(consultaRequest.getStatusConsulta())
                    .observacoes(consultaRequest.getObservacoes())
                    .sintomas(consultaRequest.getSintomas())
                    .tratamentoRecomendado(consultaRequest.getTratamentoRecomendado())
                    .custo(consultaRequest.getCusto())
                    .prescricao(consultaRequest.getPrescricao())
                    .dataRetorno(consultaRequest.getDataRetorno())
                    .build();

            Consulta consultaAtualizada = consultaService.atualizar(id, consulta);
            return ResponseEntity.ok(consultaAtualizada);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar consulta", description = "Deleta uma consulta com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable Long id) {
        try {
            consultaService.deletar(id);
            return ResponseEntity.ok("Consulta com ID " + id + " foi deletada com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos da consulta", description = "Atualiza campos específicos de uma consulta com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Consulta atualizada com sucesso"),
            @ApiResponse(responseCode = "404", description = "Consulta não encontrada"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })
    public ResponseEntity<?> atualizarParcialmente(@PathVariable Long id, @RequestBody ConsultaUpdateRequest consultaUpdateRequest) {
        try {
            Consulta consulta = consultaService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos no request
            if (consultaUpdateRequest.getTipoServico() != null) {
                consulta.setTipoServico(consultaUpdateRequest.getTipoServico());
            }
            if (consultaUpdateRequest.getDataConsulta() != null) {
                consulta.setDataConsulta(consultaUpdateRequest.getDataConsulta());
            }
            if (consultaUpdateRequest.getStatusConsulta() != null) {
                consulta.setStatusConsulta(consultaUpdateRequest.getStatusConsulta());
            }
            if (consultaUpdateRequest.getObservacoes() != null) {
                consulta.setObservacoes(consultaUpdateRequest.getObservacoes());
            }
            if (consultaUpdateRequest.getSintomas() != null) {
                consulta.setSintomas(consultaUpdateRequest.getSintomas());
            }
            if (consultaUpdateRequest.getTratamentoRecomendado() != null) {
                consulta.setTratamentoRecomendado(consultaUpdateRequest.getTratamentoRecomendado());
            }
            if (consultaUpdateRequest.getCusto() != null) {
                consulta.setCusto(consultaUpdateRequest.getCusto());
            }
            if (consultaUpdateRequest.getPrescricao() != null) {
                consulta.setPrescricao(consultaUpdateRequest.getPrescricao());
            }
            if (consultaUpdateRequest.getDataRetorno() != null) {
                consulta.setDataRetorno(consultaUpdateRequest.getDataRetorno());
            }

            Consulta consultaAtualizada = consultaService.atualizar(id, consulta);
            return ResponseEntity.ok(consultaAtualizada);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar consulta: " + e.getMessage());
        }
    }
}
