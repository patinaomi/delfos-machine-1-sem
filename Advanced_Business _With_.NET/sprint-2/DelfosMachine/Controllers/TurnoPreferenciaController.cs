using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;
using Microsoft.EntityFrameworkCore;

namespace DelfosMachine.Controllers
{
    public class TurnoPreferenciaController : Controller
    {
        private readonly ApplicationDbContext _context;

        public TurnoPreferenciaController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost("TurnoPreferencia/Criar", Name = "TurnoPreferencia")]
        public async Task<IActionResult> Criar(TurnoPreferencia turnoPreferencia)
        {
            if (ModelState.IsValid)
            {
                _context.Add(turnoPreferencia);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = "Preferência cadastrada com sucesso, clique em continuar!";
            }
            return View(turnoPreferencia);
        }

        [HttpGet("TurnoPreferencia/Consultar", Name = "ConsultarTurno")]
        public async Task<IActionResult> Consultar()
        {
            var dados = await _context.Turno.ToListAsync(); 
            return View(dados); 
        }



    }
}
