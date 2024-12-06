using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;

namespace DelfosMachine.Controllers
{
    public class ServicosPendentesController : Controller
    {
        // Lista em memória para simular os dados do banco de dados
        private static List<ServicosPendentes> servicos = new List<ServicosPendentes>
        {
            new ServicosPendentes
            {
                Id = 1,
                Cliente = "João",
                Descricao = "Consulta de rotina",
                Localizacao = "Clínica Central",
                Data = "2024-10-16",
                Hora = "10:00",
                Status = "pendente"
            },
            new ServicosPendentes
            {
                Id = 2,
                Cliente = "Maria",
                Descricao = "Avaliação odontológica",
                Localizacao = "Clínica Oeste",
                Data = "2024-10-16",
                Hora = "11:30",
                Status = "pendente"
            }
        };

        public IActionResult Index()
        {
            return View(servicos);
        }

        [HttpPost("{id}/aceitar")]
        public IActionResult AceitarServico(int id)
        {
            var servico = servicos.FirstOrDefault(s => s.Id == id);
            if (servico == null)
                return NotFound();

            servico.Status = "aceito";  // Atualiza o status para 'aceito'
            return Ok(servico);
        }

        [HttpPost("{id}/recusar")]
        public IActionResult RecusarServico(int id)
        {
            var servico = servicos.FirstOrDefault(s => s.Id == id);
            if (servico == null)
                return NotFound();

            servico.Status = "recusado"; 
            return Ok(servico);
        }
    }
}
