using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;

namespace DelfosMachine.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {   
        _logger.LogInformation("Acessou a página Index.");
        return View();
    }

    public IActionResult Hero()
    {
        return View();
    }

    public IActionResult Solucao()
    {
        return View();
    }

    public IActionResult Projeto()
    {
        return View();
    }

    public IActionResult Objetivo()
    {
        return View();
    }

    public IActionResult Persona()
    {
        return View();
    }

    public IActionResult Etapas()
    {
        return View();
    }

    public IActionResult Diagrama()
    {
        return View();
    }

    public IActionResult Time()
    {
        return View();
    }


    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}