
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface ILoginService
    {
        Task<Login> Create(Login login);
        Task<List<Login>> GetAll();
        Task<Login> GetById(string id);

    }
}
