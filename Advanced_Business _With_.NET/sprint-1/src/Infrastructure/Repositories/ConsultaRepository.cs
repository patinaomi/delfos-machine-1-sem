using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class ConsultaRepository : IConsultaRepository
    {
        private readonly IMongoCollection<Consulta> _consultasCollection;

        public ConsultaRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _consultasCollection = mongoDatabase.GetCollection<Consulta>(settings.Value.ConsultaCollectionName);
        }

        public async Task<Consulta> Create(Consulta consulta)
        {
            await _consultasCollection.InsertOneAsync(consulta);
            return consulta;
        }

        public async Task<List<Consulta>> GetAll()
        {
            return await _consultasCollection.Find(a => true).ToListAsync();
        }

        public async Task<Consulta> GetById(string id)
        {
            return await _consultasCollection.Find(a => a.IdConsulta == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Consulta consulta)
        {
            var update = Builders<Consulta>.Update
                .Set(a => a.tipo_servico, consulta.tipo_servico)
                .Set(a => a.data_consulta, consulta.data_consulta)
                .Set(a => a.status_consulta, consulta.status_consulta)
                .Set(a => a.observacoes, consulta.observacoes)
                .Set(a => a.sintomas, consulta.sintomas)
                .Set(a => a.tratamento_recomendado, consulta.tratamento_recomendado)
                .Set(a => a.custo, consulta.custo)
                .Set(a => a.prescricao, consulta.prescricao)
                .Set(a => a.data_retorno, consulta.data_retorno);

            await _consultasCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _consultasCollection.DeleteOneAsync(a => a.IdConsulta == id);
        }
    }
}
