
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface ITipoNotificacaoRepository
    {
        Task<TipoNotificacao> Create(TipoNotificacao tipoNotificacao);
        Task<List<TipoNotificacao>> GetAll();
        Task<TipoNotificacao> GetById(string id);
        Task Update(ObjectId id, TipoNotificacao tipoNotificacao);
        Task Delete(string id);
    }
}
