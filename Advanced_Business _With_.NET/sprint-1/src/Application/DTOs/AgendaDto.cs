using System;

namespace UserApi.Application.DTOs
{
    public class AgendaDto
    {
        public string IdAgenda { get; set; } = null!;
        public string IdCliente { get; set; } = null!;
        public string IdConsulta { get; set; } = null!;
        public DateTime DataConsulta { get; set; }  
        public string StatusConsulta { get; set; } = null!;  
        public string Observacoes { get; set; } = null!;
    }
}
