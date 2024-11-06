package br.com.fiap.challenge.models

data class ValidateEmailResponse(
    val message : String,
    val emailExists : Boolean,
    val email : String
)
