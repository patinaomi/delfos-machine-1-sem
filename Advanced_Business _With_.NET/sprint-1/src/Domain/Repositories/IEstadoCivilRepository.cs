
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IEstadoCivilRepository
    {
        Task<EstadoCivil> Create(EstadoCivil estadoCivil);
        Task<List<EstadoCivil>> GetAll();
        Task<EstadoCivil> GetById(string id);
        Task Update(ObjectId id, EstadoCivil estadoCivil);
        Task Delete(string id);
    }
}
