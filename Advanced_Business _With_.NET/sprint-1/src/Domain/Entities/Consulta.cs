using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Consulta
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdConsulta { get; set; }
        public string IdCliente { get; set; } = null!;
        public string IdClinica { get; set; } = null!;
        public string IdFormaPagamento { get; set; } = null!;
        public string IdTipoConsulta { get; set; } = null!;

        public string tipo_servico { get; set; } = null!;

        public DateTime data_consulta { get; set; }

        [BsonIgnore]
        public string Data => ConvertToSaoPauloTime(data_consulta).ToString("yyyy-MM-dd");

        [BsonIgnore]
        public string Hora => ConvertToSaoPauloTime(data_consulta).ToString("HH:mm:ss");

        public string status_consulta { get; set; } = null!;

        public string observacoes { get; set; } = null!;

        public string sintomas { get; set; } = null!;
    
        public string tratamento_recomendado { get; set; } = null!;

        public float custo { get; set; }

        public string prescricao { get; set; } = null!;

        public DateTime data_retorno { get; set; }

        [BsonIgnore]
        public string Data_Retorno => ConvertToSaoPauloTime(data_retorno).ToString("yyyy-MM-dd");

        [BsonIgnore]
        public string Hora_Retorno => ConvertToSaoPauloTime(data_retorno).ToString("HH:mm:ss");

          private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }


}
}
