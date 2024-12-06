
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface ISinistroService
    {
        Task<Sinistro> Create(Sinistro sinistro);
        Task<List<Sinistro>> GetAll();
        Task<Sinistro> GetById(string id);
        Task<Sinistro> Update(Sinistro sinistro);
        Task Delete(string id);
    }
}
