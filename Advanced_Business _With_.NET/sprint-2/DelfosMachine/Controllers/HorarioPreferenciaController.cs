using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;
using Microsoft.EntityFrameworkCore;

namespace DelfosMachine.Controllers
{
    public class HorarioPreferenciaController : Controller
    {
        private readonly ApplicationDbContext _context;

        public HorarioPreferenciaController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost("HorarioPreferencia/Criar", Name = "HorarioPreferencia")]
        public async Task<IActionResult> Criar(HorarioPreferencia horarioPreferencia)
        {
            if (ModelState.IsValid)
            {
                _context.Add(horarioPreferencia);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = "Preferência cadastrada com sucesso, sigar para dados cadastrais para alterar algum dado. Não esqueça de conhecer nosso programa de benefício!";
            }
            return View(horarioPreferencia);
        }

        [HttpGet("HorarioPreferencia/Consultar", Name = "ConsultarHorario")]
        public async Task<IActionResult> Consultar()
        {
            var dados = await _context.PreferenciaHorario.ToListAsync(); 
            return View(dados); 
        }



    }
}
