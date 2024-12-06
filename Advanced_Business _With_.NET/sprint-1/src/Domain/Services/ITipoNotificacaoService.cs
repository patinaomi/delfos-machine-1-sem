
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface ITipoNotificacaoService
    {
        Task<TipoNotificacao> Create(TipoNotificacao tipoNotificacao);
        Task<List<TipoNotificacao>> GetAll();
        Task<TipoNotificacao> GetById(string id);
        Task<TipoNotificacao> Update(TipoNotificacao tipoNotificacao);
        Task Delete(string id);
    }
}
