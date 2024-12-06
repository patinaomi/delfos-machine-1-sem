
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface INotificacaoService
    {
        Task<Notificacao> Create(Notificacao notificacao);
        Task<List<Notificacao>> GetAll();
        Task<Notificacao> GetById(string id);
        Task<Notificacao> Update(Notificacao notificacao);
        Task Delete(string id);
    }
}
