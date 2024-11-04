package br.com.fiap.challenge.models

data class UpdatePasswordRequest(
    val clienteId: String,
    val novaSenha: String
)
