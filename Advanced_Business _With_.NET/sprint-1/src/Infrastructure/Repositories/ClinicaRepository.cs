using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class ClinicaRepository : IClinicaRepository
    {
        private readonly IMongoCollection<Clinica> _clinicasCollection;

        public ClinicaRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _clinicasCollection = mongoDatabase.GetCollection<Clinica>(settings.Value.ClinicaCollectionName);
        }

        public async Task<Clinica> Create(Clinica clinica)
        {
            await _clinicasCollection.InsertOneAsync(clinica);
            return clinica;
        }

        public async Task<List<Clinica>> GetAll()
        {
            return await _clinicasCollection.Find(a => true).ToListAsync();
        }

        public async Task<Clinica> GetById(string id)
        {
            return await _clinicasCollection.Find(a => a.IdClinica == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Clinica clinica)
        {
            var update = Builders<Clinica>.Update
                .Set(a => a.Nome, clinica.Nome)
                .Set(a => a.Endereco, clinica.Endereco)
                .Set(a => a.Telefone, clinica.Telefone)
                .Set(a => a.Avaliacao, clinica.Avaliacao)
                .Set(a => a.PrecoMedio, clinica.PrecoMedio)
                .Set(a => a.Email, clinica.Email);

            await _clinicasCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _clinicasCollection.DeleteOneAsync(a => a.IdClinica == id);
        }
    }
}
