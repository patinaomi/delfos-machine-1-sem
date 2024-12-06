
using UserApi.Domain;
using UserApi.Domain.Entities;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class FormularioDetalhadoService : IFormularioDetalhadoService
    {
        private readonly IFormularioDetalhadoRepository _formularioDetalhadoRepository;

        public FormularioDetalhadoService(IFormularioDetalhadoRepository formularioDetalhadoRepository)
        {
            _formularioDetalhadoRepository = formularioDetalhadoRepository;
        }

        public async Task<FormularioDetalhado> Create(FormularioDetalhado formularioDetalhado)
        {
            formularioDetalhado.IdFormulario = Guid.NewGuid().ToString();

            await _formularioDetalhadoRepository.Create(formularioDetalhado);
            return formularioDetalhado; 
        }

        public async Task<List<FormularioDetalhado>> GetAll()
        {
            return await _formularioDetalhadoRepository.GetAll();
        }

        public async Task<FormularioDetalhado> GetById(string id)
        {
            return await _formularioDetalhadoRepository.GetById(id);
        }

        public async Task<FormularioDetalhado> Update(FormularioDetalhado formularioDetalhado)
        {
            if (string.IsNullOrEmpty(formularioDetalhado.IdFormulario))
            {
                throw new ArgumentNullException(nameof(formularioDetalhado.IdFormulario), "O ID do Formulário não pode ser nulo ou vazio.");
            }

            var existingFormularioDetalhado = await _formularioDetalhadoRepository.GetById(formularioDetalhado.IdFormulario);
            if (existingFormularioDetalhado == null)
            {
                throw new Exception("Formulário não encontrado");
            }

            await _formularioDetalhadoRepository.Update(existingFormularioDetalhado.Id, formularioDetalhado); 
            return formularioDetalhado; 
        }

        public async Task Delete(string id)
        {
            await _formularioDetalhadoRepository.Delete(id);
        }
    }
}
