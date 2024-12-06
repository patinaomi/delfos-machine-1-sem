


namespace UserApi.Application.DTOs
{
    public class Feedback
    {
        public string? IdFeedback { get; set; }
        public string IdCliente { get; set; } = string.Empty;
        public string IdDentista { get; set; } = string.Empty;
        public string IdClinica { get; set; } = string.Empty;
        public int Nota { get; set; }
        public string Comentario { get; set; } = string.Empty;
    }
}


