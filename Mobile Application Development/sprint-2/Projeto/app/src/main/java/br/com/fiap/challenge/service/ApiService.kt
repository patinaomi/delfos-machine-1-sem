package br.com.fiap.challenge.service

import br.com.fiap.challenge.models.LoginRequest
import br.com.fiap.challenge.models.LoginResponse
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.POST

interface ApiService {

    @POST("auth/login")
    suspend fun login(@Body loginRequest: LoginRequest): Response<LoginResponse>
}