using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
{
    public class Clinica
    {
        [BsonId]
        public ObjectId Id { get; set; }  // ID do banco
        public string? IdClinica { get; set; } = null!; 
        public string Nome { get; set; } = null!;
        public string Endereco { get; set; } = null!;
        public string Telefone { get; set; } = null!;
        public string Avaliacao { get; set; } = null!;
        public float PrecoMedio { get; set; }
        public string Email { get; set; } = null!;
}
}
