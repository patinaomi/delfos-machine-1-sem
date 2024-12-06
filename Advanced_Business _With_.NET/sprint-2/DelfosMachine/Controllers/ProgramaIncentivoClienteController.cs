using DelfosMachine.Models;
using Microsoft.AspNetCore.Mvc;

namespace DelfosMachine.Controllers
{
    public class ProgramaIncentivoClienteController : Controller
    {
        // Simulando uma fonte de dados
        private readonly List<Atividade> atividadesIniciais = new List<Atividade>
        {
            new Atividade { Id = 1, Descricao = "Completar o cadastro", Status = "concluido", Pontos = 5 },
            new Atividade { Id = 2, Descricao = "Preencher o formulário de rotina", Status = "pendente", Pontos = 5 },
            new Atividade { Id = 3, Descricao = "Preencher o formulário de preferência", Status = "concluido", Pontos = 5 },
            new Atividade { Id = 4, Descricao = "Realizar a primeira consulta sugerida/preventiva", Status = "pendente", Pontos = 5 }
        };

        // Simulando o status dos formulários preenchidos com base no IdCliente
        private bool ClientePreencheuCadastro(int idCliente) => idCliente == 1;
        private bool ClientePreencheuRotinaConsulta(int idCliente) => idCliente == 1;
        private bool ClientePreencheuPreferencia(int idCliente) => idCliente == 1;

        [HttpGet]
        public IActionResult Index(int idCliente)
        {
            // Verificando o preenchimento dos formulários
            var clienteAtividades = atividadesIniciais.Select(atividade =>
            {
                if (atividade.Descricao == "Completar o cadastro" && ClientePreencheuCadastro(idCliente))
                    atividade.Status = "concluido";
                else if (atividade.Descricao == "Preencher o formulário de rotina" && ClientePreencheuRotinaConsulta(idCliente))
                    atividade.Status = "concluido";
                else if (atividade.Descricao == "Preencher o formulário de preferência" && ClientePreencheuPreferencia(idCliente))
                    atividade.Status = "concluido";

                return atividade;
            }).ToList();

            // Calculando os pontos
            int totalPontos = clienteAtividades.Where(a => a.Status == "concluido").Sum(a => a.Pontos);

            // ViewModel com o cliente e as atividades
            var viewModel = new ProgramaIncentivoCliente
            {
                IdCliente = idCliente,
                Nome = "Delfos",
                Atividades = clienteAtividades,
                TotalPontos = totalPontos
            };

            return View(viewModel);
        }

        [HttpPost]
        public IActionResult ConcluirAtividade(int idCliente, int idAtividade)
        {
    
            return RedirectToAction("Index", new { idCliente = idCliente });
        }
    }
}
