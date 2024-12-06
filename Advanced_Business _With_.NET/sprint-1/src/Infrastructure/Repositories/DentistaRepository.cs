using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class DentistaRepository : IDentistaRepository
    {
        private readonly IMongoCollection<Dentista> _dentistasCollection;

        public DentistaRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _dentistasCollection = mongoDatabase.GetCollection<Dentista>(settings.Value.DentistaCollectionName);
        }

        public async Task<Dentista> Create(Dentista dentista)
        {
            await _dentistasCollection.InsertOneAsync(dentista);
            return dentista;
        }

        public async Task<List<Dentista>> GetAll()
        {
            return await _dentistasCollection.Find(a => true).ToListAsync();
        }

        public async Task<Dentista> GetById(string id)
        {
            return await _dentistasCollection.Find(a => a.IdDentista == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Dentista dentista)
        {
            var update = Builders<Dentista>.Update
                .Set(a => a.Nome, dentista.Nome)
                .Set(a => a.Sobrenome, dentista.Sobrenome)
                .Set(a => a.Telefone, dentista.Telefone)
                .Set(a => a.Avaliacao, dentista.Avaliacao);

            await _dentistasCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _dentistasCollection.DeleteOneAsync(a => a.IdDentista == id);
        }
    }
}
