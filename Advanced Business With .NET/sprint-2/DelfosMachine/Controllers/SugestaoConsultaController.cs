using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace DelfosMachine.Controllers
{
    public class SugestaoConsultaController : Controller
    {
        private readonly ApplicationDbContext _context;

        public SugestaoConsultaController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Consultar()
        {
            var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (int.TryParse(userIdString, out var userId))
            {
                var sugestoes = await _context.SugestaoConsulta
                    .Where(s => s.FkIdCliente == userId)
                    .ToListAsync();

                // Adiciona um log para verificar quantas sugestões foram encontradas
                Console.WriteLine($"User ID: {userId}, Sugestões encontradas: {sugestoes.Count}");

                return View(sugestoes);
            }

            return RedirectToAction("Error");
        }
    }
}
