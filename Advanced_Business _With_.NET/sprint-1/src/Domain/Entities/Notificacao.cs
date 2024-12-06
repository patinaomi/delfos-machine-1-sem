using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Notificacao
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdNotificacao { get; set; }
        public string IdCliente { get; set; } = null!;
        public string Mensagem { get; set; } = null!;
        public DateTime DataEnvio { get; set; }
        public string Data => ConvertToSaoPauloTime(DataEnvio).ToString("yyyy-MM-dd");
        public string Hora => ConvertToSaoPauloTime(DataEnvio).ToString("HH:mm:ss");

          private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }
}
}
