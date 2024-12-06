using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Application.DTOs;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CadastroController : ControllerBase
    {
        private readonly ICadastroService _cadastroService;

        public CadastroController(ICadastroService cadastroService)
        {
            _cadastroService = cadastroService;
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CadastroDto cadastroDto)
        {
            if (cadastroDto == null)
            {
                return BadRequest("Cadastro não pode ser nulo.");
            }

            // Aqui, chamamos o método correto da service, passando o DTO
            var cadastro = await _cadastroService.Create(cadastroDto);
            
            // Retornar um resultado 201 Created
            return Created("api/cadastro", cadastro); // Retorna a URL onde o recurso pode ser encontrado
        }
    }
}
