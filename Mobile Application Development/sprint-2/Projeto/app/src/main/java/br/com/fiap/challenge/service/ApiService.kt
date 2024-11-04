package br.com.fiap.challenge.service

import br.com.fiap.challenge.models.LoginRequest
import br.com.fiap.challenge.models.LoginResponse
import br.com.fiap.challenge.models.MessageResponse
import br.com.fiap.challenge.models.UpdatePasswordRequest
import br.com.fiap.challenge.models.UserResponse
import br.com.fiap.challenge.models.ValidateUserRequest
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path

interface ApiService {

    @POST("auth/login")
    suspend fun login(@Body loginRequest: LoginRequest): Response<LoginResponse>

    @GET("clientes/{clienteId}")
    suspend fun getCliente(@Path("clienteId") userId: String): Response<UserResponse>

    @POST("auth/validate-user")
    suspend fun validateUser(@Body request: ValidateUserRequest): Response<MessageResponse>

    @POST("auth/update-password")
    suspend fun updatePassword(@Body request: UpdatePasswordRequest): Response<MessageResponse>

}