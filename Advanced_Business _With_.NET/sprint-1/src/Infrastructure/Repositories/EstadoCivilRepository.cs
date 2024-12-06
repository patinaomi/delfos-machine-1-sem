using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class EstadoCivilRepository : IEstadoCivilRepository
    {
        private readonly IMongoCollection<EstadoCivil> _estadoCivilCollection;

        public EstadoCivilRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _estadoCivilCollection = mongoDatabase.GetCollection<EstadoCivil>(settings.Value.EstadoCivilCollectionName);
        }

        public async Task<EstadoCivil> Create(EstadoCivil estadoCivil)
        {
            await _estadoCivilCollection.InsertOneAsync(estadoCivil);
            return estadoCivil;
        }

        public async Task<List<EstadoCivil>> GetAll()
        {
            return await _estadoCivilCollection.Find(a => true).ToListAsync();
        }

        public async Task<EstadoCivil> GetById(string id)
        {
            return await _estadoCivilCollection.Find(a => a.IdEstadoCivil == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, EstadoCivil estadoCivil)
        {
            var update = Builders<EstadoCivil>.Update
                .Set(a => a.Descricao, estadoCivil.Descricao);

            await _estadoCivilCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _estadoCivilCollection.DeleteOneAsync(a => a.IdEstadoCivil == id);
        }
    }
}
