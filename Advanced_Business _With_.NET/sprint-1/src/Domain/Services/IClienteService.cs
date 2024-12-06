
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IClienteService
    {
        Task<Cliente> GetById(string id);
        Task<List<Cliente>> GetAll(); 
        Task<Cliente> Update(Cliente cliente);
        Task Delete(string id);
        Task<Cliente> GetByEmail(string email);
    }
}
