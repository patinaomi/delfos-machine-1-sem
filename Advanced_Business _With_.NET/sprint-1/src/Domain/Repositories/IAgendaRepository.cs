
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IAgendaRepository
    {
        Task<Agenda> Create(Agenda agenda);
        Task<List<Agenda>> GetAll();
        Task<Agenda> GetById(string id);
        Task Update(ObjectId id, Agenda agenda);
        Task Delete(string id);
    }
}
