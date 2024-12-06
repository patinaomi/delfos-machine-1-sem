using System;


namespace UserApi.Application.DTOs
{
    public class ClienteDto
    {   
        public string IdCliente { get; set; } = string.Empty;
        public string Nome { get; set; } = string.Empty;
        public string Sobrenome { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Telefone { get; set; } = string.Empty;
        public string Endereco { get; set; } = string.Empty;
        public DateTime DataNasc { get; set; }
        public string Senha { get; set; } = string.Empty;
    }
}
