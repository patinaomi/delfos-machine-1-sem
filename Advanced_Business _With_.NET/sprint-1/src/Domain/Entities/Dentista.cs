using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Dentista
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdDentista { get; set; } = null!; 
        public string Nome { get; set; } = null!;
        public string Sobrenome { get; set; } = null!;
        public string Telefone { get; set; } = null!;
        public string IdClinica { get; set; } = null!;
        public string Idespecialidade { get; set; } = null!;
        public string Avaliacao { get; set; } = null!;
}
}
