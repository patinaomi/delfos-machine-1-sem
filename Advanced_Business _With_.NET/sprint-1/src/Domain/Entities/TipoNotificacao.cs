using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class TipoNotificacao
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdTipoNotificacao { get; set; }

        public string Descricao { get; set; } = null!;
}
}
