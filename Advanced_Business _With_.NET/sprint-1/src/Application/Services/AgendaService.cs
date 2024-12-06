
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class AgendaService : IAgendaService
    {
        private readonly IAgendaRepository _agendaRepository;

        public AgendaService(IAgendaRepository agendaRepository)
        {
            _agendaRepository = agendaRepository;
        }

        public async Task<Agenda> Create(Agenda agenda)
        {
            await _agendaRepository.Create(agenda);
            return agenda; 
        }

        public async Task<List<Agenda>> GetAll()
        {
            return await _agendaRepository.GetAll();
        }

        public async Task<Agenda> GetById(string id)
        {
            return await _agendaRepository.GetById(id);
        }

        public async Task<Agenda> Update(Agenda agenda)
        {
            // Verifica se id_agenda é nulo antes de continuar
            if (string.IsNullOrEmpty(agenda.IdAgenda))
            {
                throw new ArgumentNullException(nameof(agenda.IdAgenda), "O ID da agenda não pode ser nulo ou vazio.");
            }

            var existingAgenda = await _agendaRepository.GetById(agenda.IdAgenda);
            if (existingAgenda == null)
            {
                throw new Exception("Agenda não encontrada");
            }

            // Atualiza a agenda
            await _agendaRepository.Update(existingAgenda.Id, agenda); 
            return agenda; 
        }

        public async Task Delete(string id)
        {
            await _agendaRepository.Delete(id);
        }
    }
}
