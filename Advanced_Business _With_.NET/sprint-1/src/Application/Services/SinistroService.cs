
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class SinistroService : ISinistroService
    {
        private readonly ISinistroRepository _sinistroRepository;

        public SinistroService(ISinistroRepository sinistroRepository)
        {
            _sinistroRepository = sinistroRepository;
        }

        public async Task<Sinistro> Create(Sinistro sinistro)
        {
            sinistro.IdSinistro = Guid.NewGuid().ToString();

            await _sinistroRepository.Create(sinistro);
            return sinistro; 
        }

        public async Task<List<Sinistro>> GetAll()
        {
            return await _sinistroRepository.GetAll();
        }

        public async Task<Sinistro> GetById(string id)
        {
            return await _sinistroRepository.GetById(id);
        }

        public async Task<Sinistro> Update(Sinistro sinistro)
        {
            if (string.IsNullOrEmpty(sinistro.IdSinistro))
            {
                throw new ArgumentNullException(nameof(sinistro.IdSinistro), "O ID do Sinistro não pode ser nulo ou vazio.");
            }

            var existingSinistro = await _sinistroRepository.GetById(sinistro.IdSinistro);
            if (existingSinistro == null)
            {
                throw new Exception("Sinistro não encontrado");
            }

            await _sinistroRepository.Update(existingSinistro.Id, sinistro); 
            return sinistro; 
        }

        public async Task Delete(string id)
        {
            await _sinistroRepository.Delete(id);
        }
    }
}
