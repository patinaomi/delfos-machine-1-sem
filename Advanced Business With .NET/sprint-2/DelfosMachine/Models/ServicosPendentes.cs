
namespace DelfosMachine.Models
{
    public class ServicosPendentes
    {
        public int Id { get; set; }
        public string? Cliente { get; set; }
        public string? Descricao { get; set; }
        public string? Localizacao { get; set; }
        public string? Data { get; set; }
        public string? Hora { get; set; }
        public string? Status { get; set; } // "pendente", "aceito", "recusado"

    }
}