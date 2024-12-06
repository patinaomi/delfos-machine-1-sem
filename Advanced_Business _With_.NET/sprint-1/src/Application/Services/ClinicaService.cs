
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class ClinicaService : IClinicaService
    {
        private readonly IClinicaRepository _clinicaRepository;

        public ClinicaService(IClinicaRepository clinicaRepository)
        {
            _clinicaRepository = clinicaRepository;
        }

        public async Task<Clinica> Create(Clinica clinica)
        {
            clinica.IdClinica = Guid.NewGuid().ToString();

            await _clinicaRepository.Create(clinica);
            return clinica; 
        }

        public async Task<List<Clinica>> GetAll()
        {
            return await _clinicaRepository.GetAll();
        }

        public async Task<Clinica> GetById(string id)
        {
            return await _clinicaRepository.GetById(id);
        }

        public async Task<Clinica> Update(Clinica clinica)
        {
            if (string.IsNullOrEmpty(clinica.IdClinica))
            {
                throw new ArgumentNullException(nameof(clinica.IdClinica), "O ID da clinica não pode ser nulo ou vazio.");
            }

            var existingClinica = await _clinicaRepository.GetById(clinica.IdClinica);
            if (existingClinica == null)
            {
                throw new Exception("Clinica não encontrada");
            }

            await _clinicaRepository.Update(existingClinica.Id, clinica); 
            return clinica; 
        }

        public async Task Delete(string id)
        {
            await _clinicaRepository.Delete(id);
        }
    }
}
