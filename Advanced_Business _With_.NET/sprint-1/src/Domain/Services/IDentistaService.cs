
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IDentistaService
    {
        Task<Dentista> Create(Dentista dentista);
        Task<List<Dentista>> GetAll();
        Task<Dentista> GetById(string id);
        Task<Dentista> Update(Dentista dentista);
        Task Delete(string id);
    }
}
