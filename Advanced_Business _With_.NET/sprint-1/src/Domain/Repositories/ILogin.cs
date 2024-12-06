

namespace UserApi.Domain.Repositories
{
    public interface ILoginRepository
    {
        Task<Login> Create(Login login);
        Task<List<Login>> GetAll();
        Task<Login> GetById(string id);
    }
}
