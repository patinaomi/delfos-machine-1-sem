
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IEstadoCivilService
    {
        Task<EstadoCivil> Create(EstadoCivil estadoCivil);
        Task<List<EstadoCivil>> GetAll();
        Task<EstadoCivil> GetById(string id);
        Task<EstadoCivil> Update(EstadoCivil estadoCivil);
        Task Delete(string id);
    }
}
