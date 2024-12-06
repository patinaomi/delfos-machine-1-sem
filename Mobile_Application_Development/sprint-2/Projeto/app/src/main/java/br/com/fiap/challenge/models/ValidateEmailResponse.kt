package br.com.fiap.challenge.models

data class ValidateEmailResponse(
    val emailExists : Boolean?,
    val message : String?
)
