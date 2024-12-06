package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.FormularioDetalhado;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/formularios")
@RequiredArgsConstructor
@Tag(name = "formulario", description = "Operações relacionadas a formulários detalhados")
public class FormularioDetalhadoController {

    private final FormularioDetalhadoService formularioDetalhadoService;

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
            FormularioDetalhado formulario = FormularioDetalhado.builder()
                    .cliente(formularioRequest.getCliente())
                    .estadoCivil(formularioRequest.getEstadoCivil())
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
                    .idFormulario(formularioSalvo.getIdFormulario())
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
            return ResponseEntity.ok(formularios);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar formulários: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar formulário por ID", description = "Retorna um formulário detalhado com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Long id) {
        try {
            FormularioDetalhado formulario = formularioDetalhadoService.buscarPorId(id);
            return ResponseEntity.ok(formulario);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar formulário: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar formulário", description = "Atualiza os dados de um formulário detalhado com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable Long id, @Valid @RequestBody FormularioDetalhadoRequest formularioRequest) {
        try {
            FormularioDetalhado formulario = FormularioDetalhado.builder()
                    .cliente(formularioRequest.getCliente())
                    .estadoCivil(formularioRequest.getEstadoCivil())
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

            FormularioDetalhado formularioAtualizado = formularioDetalhadoService.atualizar(id, formulario);
            return ResponseEntity.ok(formularioAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar formulário: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar formulário", description = "Deleta um formulário detalhado com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable Long id) {
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
    public ResponseEntity<?> atualizarParcialmente(@PathVariable Long id, @RequestBody FormularioDetalhadoUpdateRequest formularioDetalhadoUpdateRequest) {
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
            // Continue para todos os outros campos necessários...

            FormularioDetalhado formularioAtualizado = formularioDetalhadoService.atualizar(id, formulario);
            return ResponseEntity.ok(formularioAtualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Formulário com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar formulário: " + e.getMessage());
        }
    }
}
