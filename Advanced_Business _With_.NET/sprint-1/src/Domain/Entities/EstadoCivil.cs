using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class EstadoCivil
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdEstadoCivil { get; set; }

        public string Descricao { get; set; } = null!;
}
}
