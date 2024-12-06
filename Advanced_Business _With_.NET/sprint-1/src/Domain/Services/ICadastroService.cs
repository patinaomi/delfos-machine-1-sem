using UserApi.Application.DTOs;
using UserApi.Domain.Entities;

namespace UserApi.Application.Services
{
    public interface ICadastroService
    {
        
        Task<Cadastro> Create(CadastroDto cadastroDto);
    }
}
