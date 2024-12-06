using UserApi.Domain.Entities;

namespace UserApi.Domain.Repositories
{
    public interface ICadastroRepository
    {   
        // Método para criar um novo cadastro.
        Task Create(Cadastro cadastro); 

    }
}
