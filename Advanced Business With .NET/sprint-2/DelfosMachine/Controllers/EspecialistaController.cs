using DelfosMachine.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

[Route("Especialista")] 
public class EspecialistaController : Controller
{
    private readonly ApplicationDbContext _context;

    public EspecialistaController(ApplicationDbContext context)
    {
        _context = context;
    }

    // usar essaa tag para permitir que todos possam fazer cadastrado, mas quem não estiver logado, não vai conseguir acessar nada.
    [AllowAnonymous]
    [HttpGet("Criar")]
    public IActionResult Criar()
    {
        return View();
    }

    [AllowAnonymous]
    [HttpPost("Criar")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Criar([Bind("Id,Nome,Email,Telefone,Especialidade,CRM,Senha")] Especialista especialista)
    {
        if (ModelState.IsValid)
        {
            _context.Add(especialista);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Especialista cadastrado com sucesso!";
            return RedirectToAction("Mensagem");
        }
        return View(especialista);
    }

    [HttpGet("Mensagem")]
    public IActionResult Mensagem()
    {
        return View();
    }

    [HttpGet("Consultar")]
    public async Task<IActionResult> Consultar()
    {
        var especialistas = await _context.Especialista.ToListAsync(); 
        return View(especialistas); 
    }

    [HttpGet("Atualizar")]
    public async Task<IActionResult> Atualizar()
    {
        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userIdString) || !int.TryParse(userIdString, out var userId))
        {
            return RedirectToAction("Error");
        }

        var especialista = await _context.Especialista.FindAsync(userId);
        if (especialista == null)
        {
            return NotFound();
        }

        return View(especialista);
    }

    [HttpPost("Atualizar")]
    public async Task<IActionResult> Atualizar(Especialista especialista)
    {
        if (!ModelState.IsValid)
        {
            return View(especialista);
        }

        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userIdString) || !int.TryParse(userIdString, out var userId))
        {
            return RedirectToAction("Error");
        }

        var especialistaExistente = await _context.Especialista.FindAsync(userId);
        if (especialistaExistente == null)
        {
            return NotFound();
        }

        especialistaExistente.Nome = especialista.Nome;
        especialistaExistente.Email = especialista.Email;
        especialistaExistente.Telefone = especialista.Telefone;
        especialistaExistente.Especialidade = especialista.Especialidade;
        especialistaExistente.CRM = especialista.CRM;
        especialistaExistente.Senha = especialista.Senha;

        await _context.SaveChangesAsync();

        TempData["SuccessMessage"] = "Especialista atualizado com sucesso!";
        return RedirectToAction("MensagemAtualizacao");
    }

    [HttpGet("MensagemAtualizacao")]
    public IActionResult MensagemAtualizacao()
    {
        return View();
    }


}
