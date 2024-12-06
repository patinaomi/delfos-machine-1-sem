
using MongoDB.Bson;
using UserApi.Domain.Entities;

namespace UserApi.Domain.Repositories
{
    public interface IFormularioDetalhadoRepository
    {
        Task<FormularioDetalhado> Create(FormularioDetalhado formularioDetalhado);
        Task<List<FormularioDetalhado>> GetAll();
        Task<FormularioDetalhado> GetById(string id);
        Task Update(ObjectId id, FormularioDetalhado formularioDetalhado);
        Task Delete(string id);
    }
}
