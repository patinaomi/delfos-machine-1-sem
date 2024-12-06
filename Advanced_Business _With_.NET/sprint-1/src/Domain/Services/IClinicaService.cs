
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IClinicaService
    {
        Task<Clinica> Create(Clinica clinica);
        Task<List<Clinica>> GetAll();
        Task<Clinica> GetById(string id);
        Task<Clinica> Update(Clinica clinica);
        Task Delete(string id);
    }
}
