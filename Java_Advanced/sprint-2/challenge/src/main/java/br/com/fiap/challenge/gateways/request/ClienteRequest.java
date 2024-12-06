package br.com.fiap.challenge.gateways.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;
import org.hibernate.validator.constraints.UniqueElements;
import org.springframework.hateoas.RepresentationModel;

import java.time.LocalDate;

@Data
public class ClienteRequest extends RepresentationModel<ClienteRequest> {

    @NotNull(message = "O nome do cliente não pode ser nulo")
    @Size(max = 100, message = "O nome do cliente deve ter no máximo 100 caracteres")
    private String nome;

    @NotNull(message = "O sobrenome do cliente não pode ser nulo")
    @Size(max = 100, message = "O sobrenome do cliente deve ter no máximo 100 caracteres")
    private String sobrenome;

    @NotNull(message = "O email do cliente não pode ser nulo")
    @Email(message = "O email do cliente não é válido")
    @Size(max = 100, message = "O e-mail do cliente deve ter no máximo 100 caracteres")
    private String email;

    @NotNull(message = "O telefone do cliente não pode ser nulo")
    @Size(max = 15, message = "O telefone do cliente deve ter no máximo 15 caracteres")
    private String telefone;

    @NotNull(message = "A data de nascimento do cliente não pode ser nula")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dataNasc;

    @NotNull(message = "O endereço do cliente não pode ser nulo")
    @Size(max = 255, message = "O endereço do cliente deve ter no máximo 255 caracteres")
    private String endereco;

}
