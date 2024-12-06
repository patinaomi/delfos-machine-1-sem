using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain
    {
        public class Cliente
        {
            [BsonId]
            public ObjectId Id { get; set; }
            public string? IdCliente { get; set; }
            public string Nome { get; set; } = null!;
            public string Sobrenome { get; set; } = null!;
            public string Email { get; set; } = null!;
            public string Telefone { get; set; } = null!;
            public string Endereco { get; set; } = null!;
            public DateTime DataNasc { get; set; }
            public string Senha { get; set; } = null!;

        }
    }
