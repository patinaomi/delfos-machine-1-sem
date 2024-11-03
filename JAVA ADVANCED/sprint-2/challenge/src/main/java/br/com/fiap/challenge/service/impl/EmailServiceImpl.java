package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.service.EmailService;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    private final
    private final JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String remetente;

    public EmailServiceImpl(ClienteRepository clienteRepository, JavaMailSender javaMailSender) {
        this.clienteRepository = clienteRepository;
        this.javaMailSender = javaMailSender;
    }

    @Override
    public void enviarEmail(String destinatario, String assunto, String msg) {
        try {
            SimpleMailMessage email = new SimpleMailMessage();
            email.setFrom(remetente);
            email.setTo(destinatario);
            email.setSubject(assunto);
            email.setText(msg);
            javaMailSender.send(email);
            System.out.println("Email enviado com sucesso!");
        } catch (Exception e) {
            System.out.println("Erro ao enviar email: " + e.getMessage());
        }
    }

    public void enviarEmailErroTransacao(Long clienteId, String mensagemErro) {
        Cliente cliente = clienteRepository.findById(clienteId).orElse(null);

        if (cliente != null) {
            String mensagemErroTransacao = String.format(
                    "Olá, %s! Não foi possível completar sua transação devido ao seguinte erro:\n\n%s\n\nPor favor, tente novamente mais tarde.",
                    cliente.getNome(),
                    mensagemErro
            );
            enviarEmail(cliente.getEmail(), "Erro na Transação", mensagemErroTransacao);
        } else {
            enviarEmail(remetente, "Erro na Transação", "Ocorreu um erro durante uma transação: " + mensagemErro);
        }
    }
}

