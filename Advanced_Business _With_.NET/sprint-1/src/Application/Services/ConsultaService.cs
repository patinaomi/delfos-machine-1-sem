
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class ConsultaService : IConsultaService
    {
        private readonly IConsultaRepository _consultaRepository;

        public ConsultaService(IConsultaRepository consultaRepository)
        {
            _consultaRepository = consultaRepository;
        }

        public async Task<Consulta> Create(Consulta consulta)
        {
            consulta.IdConsulta = Guid.NewGuid().ToString();

            await _consultaRepository.Create(consulta);
            return consulta; 
        }

        public async Task<List<Consulta>> GetAll()
        {
            return await _consultaRepository.GetAll();
        }

        public async Task<Consulta> GetById(string id)
        {
            return await _consultaRepository.GetById(id);
        }

        public async Task<Consulta> Update(Consulta consulta)
        {
            if (string.IsNullOrEmpty(consulta.IdConsulta))
            {
                throw new ArgumentNullException(nameof(consulta.IdConsulta), "O ID da consulta não pode ser nulo ou vazio.");
            }

            var existingConsulta = await _consultaRepository.GetById(consulta.IdConsulta);
            if (existingConsulta == null)
            {
                throw new Exception("Consulta não encontrada");
            }

            await _consultaRepository.Update(existingConsulta.Id, consulta); 
            return consulta; 
        }

        public async Task Delete(string id)
        {
            await _consultaRepository.Delete(id);
        }
    }
}
