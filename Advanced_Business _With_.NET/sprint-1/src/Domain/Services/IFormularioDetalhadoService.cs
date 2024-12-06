
using UserApi.Domain;
using UserApi.Domain.Entities;

namespace UserApi.Application.Services
{
    public interface IFormularioDetalhadoService
    {
        Task<FormularioDetalhado> Create(FormularioDetalhado formularioDetalhado);
        Task<List<FormularioDetalhado>> GetAll();
        Task<FormularioDetalhado> GetById(string id);
        Task<FormularioDetalhado> Update(FormularioDetalhado formularioDetalhado);
        Task Delete(string id);
    }
}
