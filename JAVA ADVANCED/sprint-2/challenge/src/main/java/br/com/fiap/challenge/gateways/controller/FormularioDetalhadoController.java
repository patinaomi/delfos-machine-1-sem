package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.EstadoCivil;
import br.com.fiap.challenge.domains.FormularioDetalhado;
import br.com.fiap.challenge.gateways.repository.ClienteRepository;
import br.com.fiap.challenge.gateways.repository.EstadoCivilRepository;
import br.com.fiap.challenge.gateways.request.FormularioDetalhadoRequest;
import br.com.fiap.challenge.gateways.request.FormularioDetalhadoUpdateRequest;
import br.com.fiap.challenge.gateways.response.FormularioDetalhadoResponse;
import br.com.fiap.challenge.service.FormularioDetalhadoService;
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

import java.util.Collections;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@RestController
@RequestMapping("/formularios")
@RequiredArgsConstructor
@Tag(name = "formulario", description = "Operações relacionadas a formulários detalhados")
public class FormularioDetalhadoController {

    private final FormularioDetalhadoService formularioDetalhadoService;
    private final ClienteRepository clienteRepository;
    private final EstadoCivilRepository estadoCivilRepository;

    @Operation(summary = "Cria um novo formulário detalhado", description = "Cria um novo formulário detalhado com base nos dados informados")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Formulário criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = FormularioDetalhadoResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody FormularioDetalhadoRequest formularioRequest) {
        try {
            Cliente cliente = clienteRepository.findById(formularioRequest.getCliente())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            EstadoCivil estadoCivil = estadoCivilRepository.findById(formularioRequest.getEstadoCivil())
                    .orElseThrow(() -> new RuntimeException("Estado civil não encontrado"));

            FormularioDetalhado formulario = FormularioDetalhado.builder()
                    .cliente(cliente)
                    .estadoCivil(estadoCivil)
                    .historicoFamiliar(formularioRequest.getHistoricoFamiliar())
                    .profissao(formularioRequest.getProfissao())
                    .rendaMensal(formularioRequest.getRendaMensal())
                    .historicoMedico(formularioRequest.getHistoricoMedico())
                    .alergia(formularioRequest.getAlergia())
                    .condicaoPreexistente(formularioRequest.getCondicaoPreexistente())
                    .usoMedicamento(formularioRequest.getUsoMedicamento())
                    .familiarComDoencasDentarias(formularioRequest.getFamiliarComDoencasDentarias())
                    .participacaoEmProgramasPreventivos(formularioRequest.getParticipacaoEmProgramasPreventivos())
                    .contatoEmergencial(formularioRequest.getContatoEmergencial())
                    .pesquisaSatisfacao(formularioRequest.getPesquisaSatisfacao())
                    .dataUltimaAtualizacao(formularioRequest.getDataUltimaAtualizacao())
                    .frequenciaConsultaPeriodica(formularioRequest.getFrequenciaConsultaPeriodica())
                    .sinalizacaoDeRisco(formularioRequest.getSinalizacaoDeRisco())
                    .historicoDeViagem(formularioRequest.getHistoricoDeViagem())
                    .historicoDeMudancasDeEndereco(formularioRequest.getHistoricoDeMudancasDeEndereco())
                    .preferenciaDeContato(formularioRequest.getPreferenciaDeContato())
                    .build();

            FormularioDetalhado formularioSalvo = formularioDetalhadoService.criar(formulario);

            FormularioDetalhadoResponse formularioResponse = FormularioDetalhadoResponse.builder()
                    .cliente(formularioSalvo.getCliente())
                    .estadoCivil(formularioSalvo.getEstadoCivil())
                    .historicoFamiliar(formularioSalvo.getHistoricoFamiliar())
                    .profissao(formularioSalvo.getProfissao())
                    .rendaMensal(formularioSalvo.getRendaMensal())
                    .historicoMedico(formularioSalvo.getHistoricoMedico())
                    .alergia(formularioSalvo.getAlergia())
                    .condicaoPreexistente(formularioSalvo.getCondicaoPreexistente())
                    .usoMedicamento(formularioSalvo.getUsoMedicamento())
                    .familiarComDoencasDentarias(formularioSalvo.getFamiliarComDoencasDentarias())
                    .participacaoEmProgramasPreventivos(formularioSalvo.getParticipacaoEmProgramasPreventivos())
                    .contatoEmergencial(formularioSalvo.getContatoEmergencial())
                    .pesquisaSatisfacao(formularioSalvo.getPesquisaSatisfacao())
                    .dataUltimaAtualizacao(formularioSalvo.getDataUltimaAtualizacao())
                    .frequenciaConsultaPeriodica(formularioSalvo.getFrequenciaConsultaPeriodica())
                    .sinalizacaoDeRisco(formularioSalvo.getSinalizacaoDeRisco())
                    .historicoDeViagem(formularioSalvo.getHistoricoDeViagem())
                    .historicoDeMudancasDeEndereco(formularioSalvo.getHistoricoDeMudancasDeEndereco())
                    .preferenciaDeContato(formularioSalvo.getPreferenciaDeContato())
                    .build();

            Link link = linkTo(FormularioDetalhadoController.class).slash("formularios").slash(formularioSalvo.getIdFormulario()).withSelfRel();
            formularioResponse.add(link);

            return ResponseEntity.status(HttpStatus.CREATED).body(formularioResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar o formulário: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todos os formulários", description = "Retorna uma lista de todos os formulários detalhados")
    @GetMapping
    public ResponseEntity<?> buscarTodos() {
        try {
            List<FormularioDetalhado> formularios = formularioDetalhadoService.buscarTodos();
            if (formularios.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum formulário encontrado.");
            }

            Link selfLink = linkTo(methodOn(FormularioDetalhadoController.class).buscarTodos()).withSelfRel();
            CollectionModel<List<FormularioDetalhado>> result = CollectionModel.of(Collections.singleton(formularios), selfLink);

            return ResponseEntity.ok(formularios);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar formulários: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar formulário por ID", description = "Retorna um formulário detalhado com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            FormularioDetalhado formulario = formularioDetalhadoService.buscarPorId(id);

            FormularioDetalhadoResponse formularioDetalhadoResponse = FormularioDetalhadoResponse.builder()
                    .cliente(formulario.getCliente())
                    .estadoCivil(formulario.getEstadoCivil())
                    .historicoFamiliar(formulario.getHistoricoFamiliar())
                    .profissao(formulario.getProfissao())
                    .rendaMensal(formulario.getRendaMensal())
                    .historicoMedico(formulario.getHistoricoMedico())
                    .alergia(formulario.getAlergia())
                    .condicaoPreexistente(formulario.getCondicaoPreexistente())
                    .usoMedicamento(formulario.getUsoMedicamento())
                    .familiarComDoencasDentarias(formulario.getFamiliarComDoencasDentarias())
                    .participacaoEmProgramasPreventivos(formulario.getParticipacaoEmProgramasPreventivos())
                    .contatoEmergencial(formulario.getContatoEmergencial())
                    .pesquisaSatisfacao(formulario.getPesquisaSatisfacao())
                    .dataUltimaAtualizacao(formulario.getDataUltimaAtualizacao())
                    .frequenciaConsultaPeriodica(formulario.getFrequenciaConsultaPeriodica())
                    .sinalizacaoDeRisco(formulario.getSinalizacaoDeRisco())
                    .historicoDeViagem(formulario.getHistoricoDeViagem())
                    .historicoDeMudancasDeEndereco(formulario.getHistoricoDeMudancasDeEndereco())
                    .preferenciaDeContato(formulario.getPreferenciaDeContato())
                    .build();

            formularioDetalhadoResponse.add(linkTo(methodOn(FormularioDetalhadoController.class).buscarPorId(id)).withSelfRel());
            return ResponseEntity.ok(formularioDetalhadoResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar formulário: " + e.getMessage());
        }
    }


    @Operation(summary = "Atualizar formulário", description = "Atualiza os dados de um formulário detalhado com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable String id, @Valid @RequestBody FormularioDetalhadoRequest formularioRequest) {
        try {
            FormularioDetalhado formularioExistente = formularioDetalhadoService.buscarPorId(id);

            Cliente cliente = clienteRepository.findById(formularioRequest.getCliente())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            EstadoCivil estadoCivil = estadoCivilRepository.findById(formularioRequest.getEstadoCivil())
                    .orElseThrow(() -> new RuntimeException("Estado civil não encontrado"));

            // Atualizando os campos do formulário existente com os dados do request
            formularioExistente.setCliente(cliente);
            formularioExistente.setEstadoCivil(estadoCivil);
            formularioExistente.setHistoricoFamiliar(formularioRequest.getHistoricoFamiliar());
            formularioExistente.setProfissao(formularioRequest.getProfissao());
            formularioExistente.setRendaMensal(formularioRequest.getRendaMensal());
            formularioExistente.setHistoricoMedico(formularioRequest.getHistoricoMedico());
            formularioExistente.setAlergia(formularioRequest.getAlergia());
            formularioExistente.setCondicaoPreexistente(formularioRequest.getCondicaoPreexistente());
            formularioExistente.setUsoMedicamento(formularioRequest.getUsoMedicamento());
            formularioExistente.setFamiliarComDoencasDentarias(formularioRequest.getFamiliarComDoencasDentarias());
            formularioExistente.setParticipacaoEmProgramasPreventivos(formularioRequest.getParticipacaoEmProgramasPreventivos());
            formularioExistente.setContatoEmergencial(formularioRequest.getContatoEmergencial());
            formularioExistente.setPesquisaSatisfacao(formularioRequest.getPesquisaSatisfacao());
            formularioExistente.setDataUltimaAtualizacao(formularioRequest.getDataUltimaAtualizacao());
            formularioExistente.setFrequenciaConsultaPeriodica(formularioRequest.getFrequenciaConsultaPeriodica());
            formularioExistente.setSinalizacaoDeRisco(formularioRequest.getSinalizacaoDeRisco());
            formularioExistente.setHistoricoDeViagem(formularioRequest.getHistoricoDeViagem());
            formularioExistente.setHistoricoDeMudancasDeEndereco(formularioRequest.getHistoricoDeMudancasDeEndereco());
            formularioExistente.setPreferenciaDeContato(formularioRequest.getPreferenciaDeContato());

            FormularioDetalhado formularioAtualizado = formularioDetalhadoService.atualizar(id, formularioExistente);

            FormularioDetalhadoResponse formularioResponse = FormularioDetalhadoResponse.builder()
                    .cliente(formularioAtualizado.getCliente())
                    .estadoCivil(formularioAtualizado.getEstadoCivil())
                    .historicoFamiliar(formularioAtualizado.getHistoricoFamiliar())
                    .profissao(formularioAtualizado.getProfissao())
                    .rendaMensal(formularioAtualizado.getRendaMensal())
                    .historicoMedico(formularioAtualizado.getHistoricoMedico())
                    .alergia(formularioAtualizado.getAlergia())
                    .condicaoPreexistente(formularioAtualizado.getCondicaoPreexistente())
                    .usoMedicamento(formularioAtualizado.getUsoMedicamento())
                    .familiarComDoencasDentarias(formularioAtualizado.getFamiliarComDoencasDentarias())
                    .participacaoEmProgramasPreventivos(formularioAtualizado.getParticipacaoEmProgramasPreventivos())
                    .contatoEmergencial(formularioAtualizado.getContatoEmergencial())
                    .pesquisaSatisfacao(formularioAtualizado.getPesquisaSatisfacao())
                    .dataUltimaAtualizacao(formularioAtualizado.getDataUltimaAtualizacao())
                    .frequenciaConsultaPeriodica(formularioAtualizado.getFrequenciaConsultaPeriodica())
                    .sinalizacaoDeRisco(formularioAtualizado.getSinalizacaoDeRisco())
                    .historicoDeViagem(formularioAtualizado.getHistoricoDeViagem())
                    .historicoDeMudancasDeEndereco(formularioAtualizado.getHistoricoDeMudancasDeEndereco())
                    .preferenciaDeContato(formularioAtualizado.getPreferenciaDeContato())
                    .build();

            Link link = linkTo(methodOn(FormularioDetalhadoController.class).buscarPorId(id)).withSelfRel();
            formularioResponse.add(link);

            return ResponseEntity.ok(formularioResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar formulário: " + e.getMessage());
        }
    }


    @Operation(summary = "Deletar formulário", description = "Deleta um formulário detalhado com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable String id) {
        try {
            formularioDetalhadoService.deletar(id);
            return ResponseEntity.ok("Formulário com ID " + id + " foi deletado com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar formulário: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos do formulário detalhado", description = "Atualiza campos específicos de um formulário detalhado com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Formulário atualizado com sucesso"),
            @ApiResponse(responseCode = "404", description = "Formulário não encontrado"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })
    public ResponseEntity<?> atualizarParcialmente(@PathVariable String id, @RequestBody FormularioDetalhadoUpdateRequest formularioDetalhadoUpdateRequest) {
        try {
            FormularioDetalhado formulario = formularioDetalhadoService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos no request
            if (formularioDetalhadoUpdateRequest.getProfissao() != null) {
                formulario.setProfissao(formularioDetalhadoUpdateRequest.getProfissao());
            }
            if (formularioDetalhadoUpdateRequest.getRendaMensal() != null) {
                formulario.setRendaMensal(formularioDetalhadoUpdateRequest.getRendaMensal());
            }
            if (formularioDetalhadoUpdateRequest.getHistoricoMedico() != null) {
                formulario.setHistoricoMedico(formularioDetalhadoUpdateRequest.getHistoricoMedico());
            }
            if (formularioDetalhadoUpdateRequest.getAlergia() != null) {
                formulario.setAlergia(formularioDetalhadoUpdateRequest.getAlergia());
            }
            if (formularioDetalhadoUpdateRequest.getCondicaoPreexistente() != null) {
                formulario.setCondicaoPreexistente(formularioDetalhadoUpdateRequest.getCondicaoPreexistente());
            }
            if (formularioDetalhadoUpdateRequest.getUsoMedicamento() != null) {
                formulario.setUsoMedicamento(formularioDetalhadoUpdateRequest.getUsoMedicamento());
            }
            if (formularioDetalhadoUpdateRequest.getFamiliarComDoencasDentarias() != null) {
                formulario.setFamiliarComDoencasDentarias(formularioDetalhadoUpdateRequest.getFamiliarComDoencasDentarias());
            }
            if (formularioDetalhadoUpdateRequest.getParticipacaoEmProgramasPreventivos() != null) {
                formulario.setParticipacaoEmProgramasPreventivos(formularioDetalhadoUpdateRequest.getParticipacaoEmProgramasPreventivos());
            }
            if (formularioDetalhadoUpdateRequest.getContatoEmergencial() != null) {
                formulario.setContatoEmergencial(formularioDetalhadoUpdateRequest.getContatoEmergencial());
            }
            if (formularioDetalhadoUpdateRequest.getPesquisaSatisfacao() != null) {
                formulario.setPesquisaSatisfacao(formularioDetalhadoUpdateRequest.getPesquisaSatisfacao());
            }
            if (formularioDetalhadoUpdateRequest.getFrequenciaConsultaPeriodica() != null) {
                formulario.setFrequenciaConsultaPeriodica(formularioDetalhadoUpdateRequest.getFrequenciaConsultaPeriodica());
            }
            if (formularioDetalhadoUpdateRequest.getSinalizacaoDeRisco() != null) {
                formulario.setSinalizacaoDeRisco(formularioDetalhadoUpdateRequest.getSinalizacaoDeRisco());
            }
            if (formularioDetalhadoUpdateRequest.getHistoricoDeViagem() != null) {
                formulario.setHistoricoDeViagem(formularioDetalhadoUpdateRequest.getHistoricoDeViagem());
            }
            if (formularioDetalhadoUpdateRequest.getHistoricoDeMudancasDeEndereco() != null) {
                formulario.setHistoricoDeMudancasDeEndereco(formularioDetalhadoUpdateRequest.getHistoricoDeMudancasDeEndereco());
            }
            if (formularioDetalhadoUpdateRequest.getPreferenciaDeContato() != null) {
                formulario.setPreferenciaDeContato(formularioDetalhadoUpdateRequest.getPreferenciaDeContato());
            }

            FormularioDetalhado formularioAtualizado = formularioDetalhadoService.atualizar(id, formulario);

            FormularioDetalhadoResponse formularioResponse = FormularioDetalhadoResponse.builder()
                    .cliente(formularioAtualizado.getCliente())
                    .estadoCivil(formularioAtualizado.getEstadoCivil())
                    .historicoFamiliar(formularioAtualizado.getHistoricoFamiliar())
                    .profissao(formularioAtualizado.getProfissao())
                    .rendaMensal(formularioAtualizado.getRendaMensal())
                    .historicoMedico(formularioAtualizado.getHistoricoMedico())
                    .alergia(formularioAtualizado.getAlergia())
                    .condicaoPreexistente(formularioAtualizado.getCondicaoPreexistente())
                    .usoMedicamento(formularioAtualizado.getUsoMedicamento())
                    .familiarComDoencasDentarias(formularioAtualizado.getFamiliarComDoencasDentarias())
                    .participacaoEmProgramasPreventivos(formularioAtualizado.getParticipacaoEmProgramasPreventivos())
                    .contatoEmergencial(formularioAtualizado.getContatoEmergencial())
                    .pesquisaSatisfacao(formularioAtualizado.getPesquisaSatisfacao())
                    .dataUltimaAtualizacao(formularioAtualizado.getDataUltimaAtualizacao())
                    .frequenciaConsultaPeriodica(formularioAtualizado.getFrequenciaConsultaPeriodica())
                    .sinalizacaoDeRisco(formularioAtualizado.getSinalizacaoDeRisco())
                    .historicoDeViagem(formularioAtualizado.getHistoricoDeViagem())
                    .historicoDeMudancasDeEndereco(formularioAtualizado.getHistoricoDeMudancasDeEndereco())
                    .preferenciaDeContato(formularioAtualizado.getPreferenciaDeContato())
                    .build();

            Link link = linkTo(methodOn(FormularioDetalhadoController.class).buscarPorId(id)).withSelfRel();
            formularioResponse.add(link);

            return ResponseEntity.ok(formularioAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar formulário: " + e.getMessage());
        }
    }
}
