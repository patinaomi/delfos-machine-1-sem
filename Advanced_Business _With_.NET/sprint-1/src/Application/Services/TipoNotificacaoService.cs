
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class TipoNotificacaoService : ITipoNotificacaoService
    {
        private readonly ITipoNotificacaoRepository _tipoNotificacaoRepository;

        public TipoNotificacaoService(ITipoNotificacaoRepository tipoNotificacaoRepository)
        {
            _tipoNotificacaoRepository = tipoNotificacaoRepository;
        }

        public async Task<TipoNotificacao> Create(TipoNotificacao tipoNotificacao)
        {
            tipoNotificacao.IdTipoNotificacao = Guid.NewGuid().ToString();

            await _tipoNotificacaoRepository.Create(tipoNotificacao);
            return tipoNotificacao; 
        }

        public async Task<List<TipoNotificacao>> GetAll()
        {
            return await _tipoNotificacaoRepository.GetAll();
        }

        public async Task<TipoNotificacao> GetById(string id)
        {
            return await _tipoNotificacaoRepository.GetById(id);
        }

        public async Task<TipoNotificacao> Update(TipoNotificacao tipoNotificacao)
        {
            if (string.IsNullOrEmpty(tipoNotificacao.IdTipoNotificacao))
            {
                throw new ArgumentNullException(nameof(tipoNotificacao.IdTipoNotificacao), "O ID do Tipo de Notificação não pode ser nulo ou vazio.");
            }

            var existingTipoNotificacao = await _tipoNotificacaoRepository.GetById(tipoNotificacao.IdTipoNotificacao);
            if (existingTipoNotificacao == null)
            {
                throw new Exception("Tipo de Notificação não encontrada");
            }

            await _tipoNotificacaoRepository.Update(existingTipoNotificacao.Id, tipoNotificacao); 
            return tipoNotificacao; 
        }

        public async Task Delete(string id)
        {
            await _tipoNotificacaoRepository.Delete(id);
        }
    }
}
