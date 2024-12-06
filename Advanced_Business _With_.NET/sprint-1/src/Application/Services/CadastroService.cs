using UserApi.Application.DTOs;
using UserApi.Domain.Entities;
using UserApi.Domain.Repositories;
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public class CadastroService : ICadastroService
    {
        private readonly ICadastroRepository _cadastroRepository;
        private readonly IClienteRepository _clienteRepository;

        public CadastroService(ICadastroRepository cadastroRepository, IClienteRepository clienteRepository)
        {
            _cadastroRepository = cadastroRepository;
            _clienteRepository = clienteRepository;
        }

        public async Task<Cadastro> Create(CadastroDto cadastroDto)
        {
            // Mapeia o DTO para a entidade Cadastro
            var cadastro = new Cadastro
            {
                IdCliente = Guid.NewGuid().ToString(),
                Nome = cadastroDto.Nome,
                Sobrenome = cadastroDto.Sobrenome,
                Email = cadastroDto.Email,
                Telefone = cadastroDto.Telefone,
                DataNasc = cadastroDto.DataNasc,
                Endereco = cadastroDto.Endereco,
                Senha = cadastroDto.Senha
            };

            await _cadastroRepository.Create(cadastro);

            // Crie o cliente a partir do cadastro
            var cliente = new Cliente
            {
                IdCliente = Guid.NewGuid().ToString(),
                Nome = cadastroDto.Nome,
                Sobrenome = cadastroDto.Sobrenome,
                Email = cadastroDto.Email,
                Telefone = cadastroDto.Telefone,
                Endereco = cadastroDto.Endereco,
                DataNasc = cadastroDto.DataNasc,
                Senha = cadastroDto.Senha
            };

            // Salve o cliente na coleção, que vem do cadastro
            await _clienteRepository.Create(cliente);

            return cadastro;
        }
    }
}
