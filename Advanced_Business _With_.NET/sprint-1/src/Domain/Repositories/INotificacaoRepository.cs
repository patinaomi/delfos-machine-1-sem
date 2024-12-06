
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface INotificacaoRepository
    {
        Task<Notificacao> Create(Notificacao notificacao);
        Task<List<Notificacao>> GetAll();
        Task<Notificacao> GetById(string id);
        Task Update(ObjectId id, Notificacao notificacao);
        Task Delete(string id);
    }
}
