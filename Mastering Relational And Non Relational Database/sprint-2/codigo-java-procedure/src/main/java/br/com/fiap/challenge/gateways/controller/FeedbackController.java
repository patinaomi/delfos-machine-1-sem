package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.Clinica;
import br.com.fiap.challenge.domains.Dentista;
import br.com.fiap.challenge.domains.Feedback;
import br.com.fiap.challenge.gateways.controller.repository.ClienteRepository;
import br.com.fiap.challenge.gateways.controller.repository.ClinicaRepository;
import br.com.fiap.challenge.gateways.controller.repository.DentistaRepository;
import br.com.fiap.challenge.gateways.request.FeedbackRequest;
import br.com.fiap.challenge.gateways.request.FeedbackUpdateRequest;
import br.com.fiap.challenge.gateways.response.FeedbackResponse;
import br.com.fiap.challenge.service.FeedbackService;
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
@RequestMapping("/feedbacks")
@RequiredArgsConstructor
@Tag(name = "feedback", description = "Operações relacionadas a feedbacks")
public class FeedbackController {

    private final FeedbackService feedbackService;
    private final ClienteRepository clienteRepository;
    private final DentistaRepository dentistaRepository;
    private final ClinicaRepository clinicaRepository;

    @Operation(summary = "Cria um novo feedback", description = "Cria um novo feedback com base nos dados informados")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Feedback criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = FeedbackResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<?> criar(@Valid @RequestBody FeedbackRequest feedbackRequest) {
        try {
            Cliente cliente = clienteRepository.findById(feedbackRequest.getCliente())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            Dentista dentista = dentistaRepository.findById(feedbackRequest.getDentista())
                    .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));
            Clinica clinica = clinicaRepository.findById(feedbackRequest.getClinica())
                    .orElseThrow(() -> new RuntimeException("Clínica não encontrada"));

            Feedback feedback = Feedback.builder()
                    .cliente(cliente)
                    .dentista(dentista)
                    .clinica(clinica)
                    .avaliacao(feedbackRequest.getAvaliacao())
                    .comentario(feedbackRequest.getComentario())
                    .build();

            Feedback feedbackSalvo = feedbackService.criar(feedback);

            FeedbackResponse feedbackResponse = FeedbackResponse.builder()
                    .cliente(feedbackSalvo.getCliente())
                    .dentista(feedbackSalvo.getDentista())
                    .clinica(feedbackSalvo.getClinica())
                    .avaliacao(feedbackSalvo.getAvaliacao())
                    .comentario(feedbackSalvo.getComentario())
                    .build();

            Link link = linkTo(FeedbackController.class).slash(feedbackSalvo.getIdFeedback()).withSelfRel();
            feedbackResponse.add(link);

            return ResponseEntity.status(HttpStatus.CREATED).body(feedbackResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao criar o feedback: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar todos os feedbacks", description = "Retorna uma lista de todos os feedbacks")
    @GetMapping
    public ResponseEntity<?> buscarTodos() {
        try {
            List<Feedback> feedbacks = feedbackService.buscarTodos();
            if (feedbacks.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum feedback encontrado.");
            }

            Link selfLink = linkTo(methodOn(FeedbackController.class).buscarTodos()).withSelfRel();
            CollectionModel<List<Feedback>> result = CollectionModel.of(Collections.singleton(feedbacks), selfLink);

            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar feedbacks: " + e.getMessage());
        }
    }

    @Operation(summary = "Buscar feedback por ID", description = "Retorna um feedback com base no ID fornecido")
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            Feedback feedback = feedbackService.buscarPorId(id);
            FeedbackResponse feedbackResponse = FeedbackResponse.builder()
                    .cliente(feedback.getCliente())
                    .dentista(feedback.getDentista())
                    .clinica(feedback.getClinica())
                    .avaliacao(feedback.getAvaliacao())
                    .comentario(feedback.getComentario())
                    .build();

            feedbackResponse.add(linkTo(methodOn(FeedbackController.class).buscarPorId(id)).withSelfRel());
            return ResponseEntity.ok(feedbackResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao buscar feedback: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar feedback", description = "Atualiza os dados de um feedback com base no ID fornecido")
    @PutMapping("/{id}")
    public ResponseEntity<?> atualizar(@PathVariable String id, @Valid @RequestBody FeedbackRequest feedbackRequest) {
        try {
            Cliente cliente = clienteRepository.findById(feedbackRequest.getCliente())
                    .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
            Dentista dentista = dentistaRepository.findById(feedbackRequest.getDentista())
                    .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));
            Clinica clinica = clinicaRepository.findById(feedbackRequest.getClinica())
                    .orElseThrow(() -> new RuntimeException("Clínica não encontrada"));

            Feedback feedback = Feedback.builder()
                    .cliente(cliente)
                    .dentista(dentista)
                    .clinica(clinica)
                    .avaliacao(feedbackRequest.getAvaliacao())
                    .comentario(feedbackRequest.getComentario())
                    .build();

            Feedback feedbackAtualizado = feedbackService.atualizar(id, feedback);

            FeedbackResponse feedbackResponse = FeedbackResponse.builder()
                    .cliente(feedbackAtualizado.getCliente())
                    .dentista(feedbackAtualizado.getDentista())
                    .clinica(feedbackAtualizado.getClinica())
                    .avaliacao(feedbackAtualizado.getAvaliacao())
                    .comentario(feedbackAtualizado.getComentario())
                    .build();

            Link link = linkTo(methodOn(FeedbackController.class).buscarPorId(id)).withSelfRel();
            feedbackResponse.add(link);

            return ResponseEntity.ok(feedbackResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar feedback: " + e.getMessage());
        }
    }

    @Operation(summary = "Deletar feedback", description = "Deleta um feedback com base no ID fornecido")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletar(@PathVariable String id) {
        try {
            feedbackService.deletar(id);
            return ResponseEntity.ok("Feedback com ID " + id + " foi deletado com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar feedback: " + e.getMessage());
        }
    }

    @Operation(summary = "Atualizar campos específicos do feedback", description = "Atualiza campos específicos de um feedback com base no ID fornecido")
    @PatchMapping("/{id}")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Feedback atualizado com sucesso"),
            @ApiResponse(responseCode = "404", description = "Feedback não encontrado"),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor")
    })
    public ResponseEntity<?> atualizarParcialmente(@PathVariable String id, @RequestBody FeedbackUpdateRequest feedbackUpdateRequest) {
        try {
            Feedback feedback = feedbackService.buscarPorId(id);

            // Atualiza apenas os campos fornecidos no request
            if (feedbackUpdateRequest.getAvaliacao() != null) {
                feedback.setAvaliacao(feedbackUpdateRequest.getAvaliacao());
            }
            if (feedbackUpdateRequest.getComentario() != null) {
                feedback.setComentario(feedbackUpdateRequest.getComentario());
            }

            Feedback feedbackAtualizado = feedbackService.atualizar(id, feedback);

            FeedbackResponse feedbackResponse = FeedbackResponse.builder()
                    .cliente(feedbackAtualizado.getCliente())
                    .dentista(feedbackAtualizado.getDentista())
                    .clinica(feedbackAtualizado.getClinica())
                    .avaliacao(feedbackAtualizado.getAvaliacao())
                    .comentario(feedbackAtualizado.getComentario())
                    .build();

            Link link = linkTo(methodOn(FeedbackController.class).buscarPorId(id)).withSelfRel();
            feedbackResponse.add(link);

            return ResponseEntity.ok(feedbackResponse);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback com ID " + id + " não encontrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao atualizar feedback: " + e.getMessage());
        }
    }
}
