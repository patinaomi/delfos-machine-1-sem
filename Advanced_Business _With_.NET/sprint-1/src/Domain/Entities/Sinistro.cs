using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Sinistro
    {
        [BsonId]
        public ObjectId Id { get; set; }
        public string? IdSinistro { get; set; }
        public string IdConsulta { get; set; } = null!;
        public string Nome { get; set; } = null!;
        public string Descricao { get; set; } = null!;
        public string Status_sinistro { get; set; } = null!;
        public float Valor_sinistro { get; set; }
        public DateTime Data_abertura { get; set; }

        public string Data => ConvertToSaoPauloTime(Data_abertura).ToString("yyyy-MM-dd");

        public string Hora => ConvertToSaoPauloTime(Data_abertura).ToString("HH:mm:ss");
        public DateTime Data_resolucao { get; set; }

        public string Documentacao { get; set; } = null!;
    
          private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }
}
}
