using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Login
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdLogin { get; set; }
        public string Email { get; set; } = string.Empty;
        public string TipoLogin { get; set; } = string.Empty;
        public string Data { get; set; } = string.Empty;
        public string Hora { get; set; } = string.Empty;
        
        private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }

        public Login()
        {
            var saoPauloTime = ConvertToSaoPauloTime(DateTime.UtcNow);
            Data = saoPauloTime.ToString("yyyy-MM-dd");
            Hora = saoPauloTime.ToString("HH:mm:ss");
        }

}
}
