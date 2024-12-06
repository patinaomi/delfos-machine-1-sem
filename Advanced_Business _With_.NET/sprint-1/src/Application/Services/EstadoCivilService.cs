
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class EstadoCivilService : IEstadoCivilService
    {
        private readonly IEstadoCivilRepository _estadoCivilRepository;

        public EstadoCivilService(IEstadoCivilRepository estadoCivilRepository)
        {
            _estadoCivilRepository = estadoCivilRepository;
        }

        public async Task<EstadoCivil> Create(EstadoCivil estadoCivil)
        {
            estadoCivil.IdEstadoCivil = Guid.NewGuid().ToString();

            await _estadoCivilRepository.Create(estadoCivil);
            return estadoCivil; 
        }

        public async Task<List<EstadoCivil>> GetAll()
        {
            return await _estadoCivilRepository.GetAll();
        }

        public async Task<EstadoCivil> GetById(string id)
        {
            return await _estadoCivilRepository.GetById(id);
        }

        public async Task<EstadoCivil> Update(EstadoCivil estadoCivil)
        {
            if (string.IsNullOrEmpty(estadoCivil.IdEstadoCivil))
            {
                throw new ArgumentNullException(nameof(estadoCivil.IdEstadoCivil), "O ID do Estado Civil não pode ser nulo ou vazio.");
            }

            var existingEstadoCivil = await _estadoCivilRepository.GetById(estadoCivil.IdEstadoCivil);
            if (existingEstadoCivil == null)
            {
                throw new Exception("Estado Civil não encontrada");
            }

            await _estadoCivilRepository.Update(existingEstadoCivil.Id, estadoCivil); 
            return estadoCivil; 
        }

        public async Task Delete(string id)
        {
            await _estadoCivilRepository.Delete(id);
        }
    }
}
