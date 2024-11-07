using DelfosMachine.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("RotinaCuidadoCliente")] 
public class RotinaCuidadoClienteController : Controller
{
    private readonly ApplicationDbContext _context;

    public RotinaCuidadoClienteController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("Criar")]
    public IActionResult Criar()
    {
        return View();
    }

    [HttpPost("Criar")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Criar(RotinaCuidadoCliente rotinaCuidado)
    {
        if (ModelState.IsValid)
            {

                var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (int.TryParse(userId, out int clienteId))
                {
                    rotinaCuidado.IdCliente = clienteId;
                }
                else
                {
                    ModelState.AddModelError("", "Erro ao obter o ID do cliente logado.");
                    return View(rotinaCuidado);
                }

                _context.Add(rotinaCuidado);
                await _context.SaveChangesAsync(); 
                
                TempData["SuccessMessage"] = "Rotina de cuidado cadastrada com sucesso!";
                return RedirectToAction("MensagemSucesso");
        }
        return View(rotinaCuidado);
    }

    [HttpGet("MensagemSucesso")]
    public IActionResult MensagemSucesso()
    {
        return View();
    }

    [HttpGet("Consultar")]
    public async Task<IActionResult> Consultar()
    {
        var rotinas = await _context.RotinaCuidado.ToListAsync(); 
        return View(rotinas); 
    }

}
