
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class DentistaService : IDentistaService
    {
        private readonly IDentistaRepository _dentistaRepository;

        public DentistaService(IDentistaRepository dentistaRepository)
        {
            _dentistaRepository = dentistaRepository;
        }

        public async Task<Dentista> Create(Dentista dentista)
        {
            dentista.IdDentista = Guid.NewGuid().ToString();

            await _dentistaRepository.Create(dentista);
            return dentista; 
        }

        public async Task<List<Dentista>> GetAll()
        {
            return await _dentistaRepository.GetAll();
        }

        public async Task<Dentista> GetById(string id)
        {
            return await _dentistaRepository.GetById(id);
        }

        public async Task<Dentista> Update(Dentista dentista)
        {
            if (string.IsNullOrEmpty(dentista.IdDentista))
            {
                throw new ArgumentNullException(nameof(dentista.IdDentista), "O ID do dentista não pode ser nulo ou vazio.");
            }

            var existingDentista = await _dentistaRepository.GetById(dentista.IdDentista);
            if (existingDentista == null)
            {
                throw new Exception("Dentista não encontrada");
            }

            await _dentistaRepository.Update(existingDentista.Id, dentista); 
            return dentista; 
        }

        public async Task Delete(string id)
        {
            await _dentistaRepository.Delete(id);
        }
    }
}
