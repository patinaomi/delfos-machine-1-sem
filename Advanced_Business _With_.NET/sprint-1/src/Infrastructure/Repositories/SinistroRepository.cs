using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class SinistroRepository : ISinistroRepository
    {
        private readonly IMongoCollection<Sinistro> _sinistroCollection;

        public SinistroRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _sinistroCollection = mongoDatabase.GetCollection<Sinistro>(settings.Value.SinistroCollectionName);
        }

        public async Task<Sinistro> Create(Sinistro sinistro)
        {
            await _sinistroCollection.InsertOneAsync(sinistro);
            return sinistro;
        }

        public async Task<List<Sinistro>> GetAll()
        {
            return await _sinistroCollection.Find(a => true).ToListAsync();
        }

        public async Task<Sinistro> GetById(string id)
        {
            return await _sinistroCollection.Find(a => a.IdSinistro == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Sinistro sinistro)
        {
            var update = Builders<Sinistro>.Update
                .Set(a => a.Nome, sinistro.Nome)
                .Set(a => a.Descricao, sinistro.Descricao)
                .Set(a => a.Status_sinistro, sinistro.Status_sinistro)
                .Set(a => a.Valor_sinistro, sinistro.Valor_sinistro)
                .Set(a => a.Data_abertura, sinistro.Data_abertura)
                .Set(a => a.Data_resolucao, sinistro.Data_resolucao)
                .Set(a => a.Documentacao, sinistro.Documentacao);

            await _sinistroCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _sinistroCollection.DeleteOneAsync(a => a.IdSinistro == id);
        }
    }
}
