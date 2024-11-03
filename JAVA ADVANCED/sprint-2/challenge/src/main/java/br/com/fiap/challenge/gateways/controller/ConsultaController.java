package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Consulta;
import br.com.fiap.challenge.domains.Dentista;
import br.com.fiap.challenge.gateways.repository.ClienteRepository;
import br.com.fiap.challenge.gateways.repository.ClinicaRepository;
import br.com.fiap.challenge.gateways.repository.DentistaRepository;
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
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.Link;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.Collections;
import java.util.List;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@RestController
@RequestMapping("/consultas")
@RequiredArgsConstructor
@Tag(name = "consulta", description = "Operações relacionadas a consultas")
public class ConsultaController {

    private final ConsultaService consultaService;
    private final ClienteRepository clienteRepository;
    private final ClinicaRepository clinicaRepository;
    private final DentistaRepository dentistaRepository;

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
            Cliente cliente = clienteRepository.findById(consultaRequest.getClienteId())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            Clinica clinica = clinicaRepository.findById(consultaRequest.getClinicaId())
                    .orElseThrow(() -> new RuntimeException("Clínica não encontrada"));
            Dentista dentista = dentistaRepository.findById(consultaRequest.getDentistaId())
                    .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));

            Consulta consulta = Consulta.builder()
                    .cliente(cliente)
                    .clinica(clinica)
                    .dentista(dentista)
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

            Link link = linkTo(ConsultaController.class).slash(consultaSalva.getIdConsulta()).withSelfRel();
            consultaResponse.add(link);

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

            Link selfLink = linkTo(methodOn(ConsultaController.class).buscarTodas()).withSelfRel();
            CollectionModel<List<Consulta>> result = CollectionModel.of(Collections.singleton(consultas), selfLink);

            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar consultas: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar consulta por ID", description = "Retorna uma consulta com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            Consulta consulta = consultaService.buscarPorId(id);
            ConsultaResponse consultaResponse = ConsultaResponse.builder()
                    .cliente(consulta.getCliente())
                    .clinica(consulta.getClinica())
                    .dentista(consulta.getDentista())
                    .tipoServico(consulta.getTipoServico())
                    .dataConsulta(consulta.getDataConsulta())
                    .statusConsulta(consulta.getStatusConsulta())
                    .observacoes(consulta.getObservacoes())
                    .sintomas(consulta.getSintomas())
                    .tratamentoRecomendado(consulta.getTratamentoRecomendado())
                    .custo(consulta.getCusto())
                    .prescricao(consulta.getPrescricao())
                    .dataRetorno(consulta.getDataRetorno())
                    .build();

            consultaResponse.add(linkTo(methodOn(ConsultaController.class).buscarPorId(id)).withSelfRel());
            return ResponseEntity.ok(consultaResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar consulta", description = "Atualiza os dados de uma consulta com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable String id, @Valid @RequestBody ConsultaRequest consultaRequest) {
        try {
            Cliente cliente = clienteRepository.findById(consultaRequest.getClienteId())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            Clinica clinica = clinicaRepository.findById(consultaRequest.getClinicaId())
                    .orElseThrow(() -> new RuntimeException("Clínica não encontrada"));
            Dentista dentista = dentistaRepository.findById(consultaRequest.getDentistaId())
                    .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));

            Consulta consulta = Consulta.builder()
                    .cliente(cliente)
                    .clinica(clinica)
                    .dentista(dentista)
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

            ConsultaResponse consultaResponse = ConsultaResponse.builder()
                    .cliente(consultaAtualizada.getCliente())
                    .clinica(consultaAtualizada.getClinica())
                    .dentista(consultaAtualizada.getDentista())
                    .tipoServico(consultaAtualizada.getTipoServico())
                    .dataConsulta(consultaAtualizada.getDataConsulta())
                    .statusConsulta(consultaAtualizada.getStatusConsulta())
                    .observacoes(consultaAtualizada.getObservacoes())
                    .sintomas(consultaAtualizada.getSintomas())
                    .tratamentoRecomendado(consultaAtualizada.getTratamentoRecomendado())
                    .custo(consultaAtualizada.getCusto())
                    .prescricao(consultaAtualizada.getPrescricao())
                    .dataRetorno(consultaAtualizada.getDataRetorno())
                    .build();

            Link link = linkTo(methodOn(ConsultaController.class).atualizar(id, consultaRequest)).withSelfRel();
            consultaResponse.add(link);

            return ResponseEntity.ok(consultaResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar consulta: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar consulta", description = "Deleta uma consulta com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable String id) {
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
    public ResponseEntity<?> atualizarParcialmente(@PathVariable String id, @RequestBody ConsultaUpdateRequest consultaUpdateRequest) {
        try {
            Consulta consulta = consultaService.buscarPorId(id);

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

            ConsultaResponse consultaResponse = ConsultaResponse.builder()
                    .cliente(consultaAtualizada.getCliente())
                    .clinica(consultaAtualizada.getClinica())
                    .dentista(consultaAtualizada.getDentista())
                    .tipoServico(consultaAtualizada.getTipoServico())
                    .dataConsulta(consultaAtualizada.getDataConsulta())
                    .statusConsulta(consultaAtualizada.getStatusConsulta())
                    .observacoes(consultaAtualizada.getObservacoes())
                    .sintomas(consultaAtualizada.getSintomas())
                    .tratamentoRecomendado(consultaAtualizada.getTratamentoRecomendado())
                    .custo(consultaAtualizada.getCusto())
                    .prescricao(consultaAtualizada.getPrescricao())
                    .dataRetorno(consultaAtualizada.getDataRetorno())
                    .build();

            Link link = linkTo(methodOn(ConsultaController.class).atualizarParcialmente(id, consultaUpdateRequest)).withSelfRel();
            consultaResponse.add(link);

            return ResponseEntity.ok(consultaResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Consulta com ID " + id + " não encontrada.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar consulta: " + e.getMessage());
        }
    }
}
