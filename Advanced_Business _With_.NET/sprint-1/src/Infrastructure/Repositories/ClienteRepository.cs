using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class ClienteRepository : IClienteRepository
    {
        private readonly IMongoCollection<Cliente> _clientesCollection;

        public ClienteRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _clientesCollection = mongoDatabase.GetCollection<Cliente>(settings.Value.ClienteCollectionName);
        }

        public async Task<Cliente> GetById(string id)
        {
            return await _clientesCollection.Find(c => c.IdCliente == id).FirstOrDefaultAsync();
        }

        public async Task<List<Cliente>> GetAll()
        {
            return await _clientesCollection.Find(u => true).ToListAsync();
        }

        public async Task Update(ObjectId id, Cliente cliente)
        {
            var update = Builders<Cliente>.Update
                .Set(c => c.Nome, cliente.Nome)
                .Set(c => c.Sobrenome, cliente.Sobrenome)
                .Set(c => c.Email, cliente.Email)
                .Set(c => c.Telefone, cliente.Telefone)
                .Set(c => c.Endereco, cliente.Endereco)
                .Set(c => c.DataNasc, cliente.DataNasc)
                .Set(c => c.Senha, cliente.Senha);

            await _clientesCollection.UpdateOneAsync(c => c.Id == id, update);
        }


        public async Task Delete(string id)
        {
            await _clientesCollection.DeleteOneAsync(c => c.IdCliente == id);
        }

        public async Task<Cliente> GetByEmail(string email)
        {
            return await _clientesCollection.Find(c => c.Email == email).FirstOrDefaultAsync();
        }

        public async Task Create(Cliente cliente)
        {
            await _clientesCollection.InsertOneAsync(cliente);
        }

    }
}
