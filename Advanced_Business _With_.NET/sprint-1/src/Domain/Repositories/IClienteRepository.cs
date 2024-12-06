
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IClienteRepository
    {
        Task Create(Cliente cliente);
        Task<List<Cliente>> GetAll();
        Task<Cliente> GetById(string id);
        Task<Cliente> GetByEmail(string email);
        Task Update(ObjectId id, Cliente cliente);
        Task Delete(string id);
        
    }
}
