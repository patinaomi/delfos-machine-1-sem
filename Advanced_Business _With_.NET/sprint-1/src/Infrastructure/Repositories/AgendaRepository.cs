using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class AgendaRepository : IAgendaRepository
    {
        private readonly IMongoCollection<Agenda> _agendasCollection;

        public AgendaRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _agendasCollection = mongoDatabase.GetCollection<Agenda>(settings.Value.AgendaCollectionName);
        }

        public async Task<Agenda> Create(Agenda agenda)
        {
            await _agendasCollection.InsertOneAsync(agenda);
            return agenda;
        }

        public async Task<List<Agenda>> GetAll()
        {
            return await _agendasCollection.Find(a => true).ToListAsync();
        }

        public async Task<Agenda> GetById(string id)
        {
            return await _agendasCollection.Find(a => a.IdAgenda == id).FirstOrDefaultAsync();
        }

        

        public async Task Update(ObjectId id, Agenda agenda)
        {
            var update = Builders<Agenda>.Update
                .Set(a => a.DataConsulta, agenda.DataConsulta)
                .Set(a => a.StatusConsulta, agenda.StatusConsulta)
                .Set(a => a.Observacoes, agenda.Observacoes);

            await _agendasCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _agendasCollection.DeleteOneAsync(a => a.IdAgenda == id);
        }
    }
}
