namespace UserApi.Domain.Entities
{
    public class Cadastro
    {
        public string? IdCliente { get; set; }
        public string Nome { get; set; } = null!;
        public string Sobrenome { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Telefone { get; set; } = null!;
        public DateTime DataNasc { get; set; }
        public string Endereco { get; set; } = null!;
        public string Senha { get; set; } = null!;


    }
}
