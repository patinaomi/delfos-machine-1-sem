using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;
using Microsoft.EntityFrameworkCore;

namespace DelfosMachine.Controllers
{
    public class DiaSemanaPreferenciaController : Controller
    {
        private readonly ApplicationDbContext _context;

        public DiaSemanaPreferenciaController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost("DiaSemanaPreferencia/Criar", Name = "DiaSemanaPreferencia")]
        public async Task<IActionResult> Criar(DiaSemanaPreferencia dia)
        {
            if (ModelState.IsValid)
            {
                _context.Add(dia);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = "Preferência cadastrada com sucesso, clique em continuar!";
            }
            return View(dia);
        }

        [HttpGet("DiaSemanaPreferencia/Consultar", Name = "ConsultarDiasSemana")]
        public async Task<IActionResult> Consultar()
        {
            var dados = await _context.PreferenciaDia.ToListAsync(); 
            return View(dados); 
        }



    }
}
