
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class LoginService : ILoginService
    {
        private readonly ILoginRepository _loginRepository;

        public LoginService(ILoginRepository loginRepository)
        {
            _loginRepository = loginRepository;
        }

        public async Task<Login> Create(Login login)
        {
            login.IdLogin = Guid.NewGuid().ToString();

            await _loginRepository.Create(login);
            return login; 
        }

        public async Task<List<Login>> GetAll()
        {
            return await _loginRepository.GetAll();
        }

        public async Task<Login> GetById(string id)
        {
            return await _loginRepository.GetById(id);
        }
    }
}
