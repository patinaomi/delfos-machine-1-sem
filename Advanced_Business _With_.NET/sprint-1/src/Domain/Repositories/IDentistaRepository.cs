
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IDentistaRepository
    {
        Task<Dentista> Create(Dentista dentista);
        Task<List<Dentista>> GetAll();
        Task<Dentista> GetById(string id);
        Task Update(ObjectId id, Dentista dentista);
        Task Delete(string id);
    }
}
