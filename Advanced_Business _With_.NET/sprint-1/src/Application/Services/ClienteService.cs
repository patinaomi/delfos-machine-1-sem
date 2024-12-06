
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class ClienteService : IClienteService
    {
        private readonly IClienteRepository _clienteRepository;

        public ClienteService(IClienteRepository clienteRepository)
        {
            _clienteRepository = clienteRepository;
        }

        public async Task<Cliente> GetById(string id)
        {
            return await _clienteRepository.GetById(id);
        }

        public async Task<List<Cliente>> GetAll() 
        {
            return await _clienteRepository.GetAll();
        }

        public async Task<Cliente> Update(Cliente cliente)
        {
            // Verifica se IdCliente é nulo antes de continuar
            if (string.IsNullOrEmpty(cliente.IdCliente))
            {
                throw new ArgumentNullException(nameof(cliente.IdCliente), "O ID do cliente não pode ser nulo ou vazio.");
            }

            var existingCliente = await _clienteRepository.GetById(cliente.IdCliente);
            if (existingCliente == null)
            {
                throw new Exception("Cliente não encontrado");
            }

            await _clienteRepository.Update(existingCliente.Id, cliente);
            return cliente; // Retorna o cliente atualizado
        }

        public async Task Delete(string id)
        {
            await _clienteRepository.Delete(id);
        }

        public async Task<Cliente> GetByEmail(string email)
        {
            return await _clienteRepository.GetByEmail(email);
        }
    }
}
