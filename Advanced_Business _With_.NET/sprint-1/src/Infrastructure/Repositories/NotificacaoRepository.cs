using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class NotificacaoRepository : INotificacaoRepository
    {
        private readonly IMongoCollection<Notificacao> _notificacaoCollection;

        public NotificacaoRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _notificacaoCollection = mongoDatabase.GetCollection<Notificacao>(settings.Value.NotificacaoCollectionName);
        }

        public async Task<Notificacao> Create(Notificacao notificacao)
        {
            await _notificacaoCollection.InsertOneAsync(notificacao);
            return notificacao;
        }

        public async Task<List<Notificacao>> GetAll()
        {
            return await _notificacaoCollection.Find(a => true).ToListAsync();
        }

        public async Task<Notificacao> GetById(string id)
        {
            return await _notificacaoCollection.Find(a => a.IdNotificacao == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Notificacao notificacao)
        {
            var update = Builders<Notificacao>.Update
                .Set(a => a.Mensagem, notificacao.Mensagem)
                .Set(a => a.DataEnvio, notificacao.DataEnvio);

            await _notificacaoCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _notificacaoCollection.DeleteOneAsync(a => a.IdNotificacao == id);
        }
    }
}
