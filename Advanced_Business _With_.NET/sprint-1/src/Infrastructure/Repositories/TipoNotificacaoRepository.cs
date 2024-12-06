using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class TipoNotificacaoRepository : ITipoNotificacaoRepository
    {
        private readonly IMongoCollection<TipoNotificacao> _tipoNotificacaoCollection;

        public TipoNotificacaoRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _tipoNotificacaoCollection = mongoDatabase.GetCollection<TipoNotificacao>(settings.Value.TipoNotificacaoCollectionName);
        }

        public async Task<TipoNotificacao> Create(TipoNotificacao tipoNotificacao)
        {
            await _tipoNotificacaoCollection.InsertOneAsync(tipoNotificacao);
            return tipoNotificacao;
        }

        public async Task<List<TipoNotificacao>> GetAll()
        {
            return await _tipoNotificacaoCollection.Find(a => true).ToListAsync();
        }

        public async Task<TipoNotificacao> GetById(string id)
        {
            return await _tipoNotificacaoCollection.Find(a => a.IdTipoNotificacao == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, TipoNotificacao tipoNotificacao)
        {
            var update = Builders<TipoNotificacao>.Update
                .Set(a => a.Descricao, tipoNotificacao.Descricao);

            await _tipoNotificacaoCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _tipoNotificacaoCollection.DeleteOneAsync(a => a.IdTipoNotificacao == id);
        }
    }
}
