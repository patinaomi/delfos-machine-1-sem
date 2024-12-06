using DelfosMachine.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Threading.Tasks;

[Route("Cliente")] 
public class ClienteController : Controller
{
    private readonly ApplicationDbContext _context;

    public ClienteController(ApplicationDbContext context)
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
    public async Task<IActionResult> Criar([Bind("Id,Nome,Email,Telefone,Genero,DataNasc,Senha")] Cliente cliente)
    {
        if (ModelState.IsValid)
        {
            _context.Add(cliente);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Cliente cadastrado com sucesso!";
            return RedirectToAction("Mensagem");
        }
        return View(cliente);
    }

    [HttpGet("Mensagem")]
    public IActionResult Mensagem()
    {
        return View();
    }

    [HttpGet("Consultar")]
    public async Task<IActionResult> Consultar()
    {
        var clientes = await _context.Clientes.ToListAsync(); 
        return View(clientes); 
    }

    [HttpGet("Atualizar")]
    public async Task<IActionResult> Atualizar()
    {
        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userIdString) || !int.TryParse(userIdString, out var userId))
        {
            return RedirectToAction("Error");
        }

        var cliente = await _context.Clientes.FindAsync(userId);
        if (cliente == null)
        {
            return NotFound();
        }

        return View(cliente);
    }

    [HttpPost("Atualizar")]
    public async Task<IActionResult> Atualizar(Cliente cliente)
    {
        if (!ModelState.IsValid)
        {
            return View(cliente);
        }

        var userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

        if (string.IsNullOrEmpty(userIdString) || !int.TryParse(userIdString, out var userId))
        {
            return RedirectToAction("Error");
        }

        var clienteExistente = await _context.Clientes.FindAsync(userId);
        if (clienteExistente == null)
        {
            return NotFound();
        }

        clienteExistente.Nome = cliente.Nome;
        clienteExistente.Email = cliente.Email;
        clienteExistente.Telefone = cliente.Telefone;
        clienteExistente.Genero = cliente.Genero;
        clienteExistente.DataNasc = cliente.DataNasc;
        clienteExistente.Senha = cliente.Senha;

        await _context.SaveChangesAsync();

        TempData["SuccessMessage"] = "Cliente atualizado com sucesso!";
        return RedirectToAction("MensagemAtualizacao");
    }

    [HttpGet("MensagemAtualizacao")]
    public IActionResult MensagemAtualizacao()
    {
        return View();
    }


}
