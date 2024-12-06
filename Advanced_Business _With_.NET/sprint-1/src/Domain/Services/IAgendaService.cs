
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IAgendaService
    {
        Task<Agenda> Create(Agenda agenda);
        Task<List<Agenda>> GetAll();
        Task<Agenda> GetById(string id);
        Task<Agenda> Update(Agenda agenda);
        Task Delete(string id);
    }
}
