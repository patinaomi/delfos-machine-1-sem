
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IConsultaRepository
    {
        Task<Consulta> Create(Consulta consulta);
        Task<List<Consulta>> GetAll();
        Task<Consulta> GetById(string id);
        Task Update(ObjectId id, Consulta consulta);
        Task Delete(string id);
    }
}
