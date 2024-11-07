using DelfosMachine.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;


[Route("DadosCadastraisMedicos")]
public class DadosCadastraisMedicosController : Controller
{
    private readonly ApplicationDbContext _context;

    public DadosCadastraisMedicosController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("Consultar")]
    public async Task<IActionResult> Consultar()
    {
        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (int.TryParse(userIdString, out var userId))
        {
            var especialista = await _context.Especialista.FirstOrDefaultAsync(c => c.Id == userId);
            if (especialista == null)
            {
                return RedirectToAction("Error");
            }


            // Cria a instância de DadosCadastrais
            var dadosCadastraisMedicos = new DadosCadastraisMedicos
            {
                Especialista = especialista,
      
            };

            return View(dadosCadastraisMedicos);
        }

        return RedirectToAction("Error");
    }
}
