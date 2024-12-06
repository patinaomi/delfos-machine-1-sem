package br.com.fiap.challenge.service;

public interface EmailService {
    void enviarEmail(String destinatario, String assunto, String msg);
}
