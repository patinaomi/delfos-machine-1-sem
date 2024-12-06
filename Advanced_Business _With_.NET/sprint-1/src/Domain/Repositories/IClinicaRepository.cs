
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IClinicaRepository
    {
        Task<Clinica> Create(Clinica clinica);
        Task<List<Clinica>> GetAll();
        Task<Clinica> GetById(string id);
        Task Update(ObjectId id, Clinica clinica);
        Task Delete(string id);
    }
}
