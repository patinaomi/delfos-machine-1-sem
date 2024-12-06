
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class NotificacaoService : INotificacaoService
    {
        private readonly INotificacaoRepository _notificacaoRepository;

        public NotificacaoService(INotificacaoRepository notificacaoRepository)
        {
            _notificacaoRepository = notificacaoRepository;
        }

        public async Task<Notificacao> Create(Notificacao notificacao)
        {
            notificacao.IdNotificacao = Guid.NewGuid().ToString();

            await _notificacaoRepository.Create(notificacao);
            return notificacao; 
        }

        public async Task<List<Notificacao>> GetAll()
        {
            return await _notificacaoRepository.GetAll();
        }

        public async Task<Notificacao> GetById(string id)
        {
            return await _notificacaoRepository.GetById(id);
        }

        public async Task<Notificacao> Update(Notificacao notificacao)
        {
            if (string.IsNullOrEmpty(notificacao.IdNotificacao))
            {
                throw new ArgumentNullException(nameof(notificacao.IdNotificacao), "O ID de Notificação não pode ser nulo ou vazio.");
            }

            var existingNotificacao = await _notificacaoRepository.GetById(notificacao.IdNotificacao);
            if (existingNotificacao == null)
            {
                throw new Exception("Notificação não encontrada");
            }

            await _notificacaoRepository.Update(existingNotificacao.Id, notificacao); 
            return notificacao; 
        }

        public async Task Delete(string id)
        {
            await _notificacaoRepository.Delete(id);
        }
    }
}
