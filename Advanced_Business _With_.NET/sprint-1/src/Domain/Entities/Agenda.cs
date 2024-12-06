using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Agenda
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco

        public string IdAgenda { get; set; } = null!;  
        
        public string IdCliente { get; set; } = null!;  

        public string IdConsulta { get; set; } = null!; 

        public DateTime DataConsulta { get; set; } 

        [BsonIgnore]
        public string Data => ConvertToSaoPauloTime(DataConsulta).ToString("yyyy-MM-dd");  // Formatação da data

        [BsonIgnore]
        public string Hora => ConvertToSaoPauloTime(DataConsulta).ToString("HH:mm:ss");  // Formatação da hora

        private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }

        public string StatusConsulta { get; set; } = null!;  // Status da consulta

        public string Observacoes { get; set; } = null!;  // Observações
    }
}
