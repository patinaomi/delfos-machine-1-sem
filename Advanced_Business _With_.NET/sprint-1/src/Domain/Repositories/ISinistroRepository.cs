
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface ISinistroRepository
    {
        Task<Sinistro> Create(Sinistro sinistro);
        Task<List<Sinistro>> GetAll();
        Task<Sinistro> GetById(string id);
        Task Update(ObjectId id, Sinistro sinistro);
        Task Delete(string id);
    }
}
