
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IConsultaService
    {
        Task<Consulta> Create(Consulta consulta);
        Task<List<Consulta>> GetAll();
        Task<Consulta> GetById(string id);
        Task<Consulta> Update(Consulta consulta);
        Task Delete(string id);
    }
}
