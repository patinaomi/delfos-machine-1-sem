using DelfosMachine.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Threading.Tasks;

[Route("DadosCadastrais")]
public class DadosCadastraisController : Controller
{
    private readonly ApplicationDbContext _context;

    public DadosCadastraisController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("Consultar")]
    public async Task<IActionResult> Consultar()
    {
        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        // Verifica se userIdString é um inteiro válido
        if (int.TryParse(userIdString, out var userId))
        {
            // Busca o cliente pelo ID
            var cliente = await _context.Clientes.FirstOrDefaultAsync(c => c.Id == userId);
            if (cliente == null)
            {
                return RedirectToAction("Error");
            }

            var endereco = await _context.EnderecoPreferencia.FirstOrDefaultAsync(e => e.IdCliente == userId) ?? new EnderecoPreferencia();
            var diaSemana = await _context.PreferenciaDia.FirstOrDefaultAsync(d => d.IdCliente == userId) ?? new DiaSemanaPreferencia();
            var turno = await _context.Turno.FirstOrDefaultAsync(t => t.IdCliente == userId) ?? new TurnoPreferencia();
            var horario = await _context.PreferenciaHorario.FirstOrDefaultAsync(h => h.IdCliente == userId) ?? new HorarioPreferencia();

            // Cria a instância de DadosCadastrais
            var dadosCadastrais = new DadosCadastrais
            {
                Cliente = cliente,
                Endereco = endereco,
                DiaSemana = diaSemana,
                Turnos = turno,
                Horarios = horario
            };

            return View(dadosCadastrais);
        }

        return RedirectToAction("Error"); // ou outra ação se o userId não for válido
    }
}
