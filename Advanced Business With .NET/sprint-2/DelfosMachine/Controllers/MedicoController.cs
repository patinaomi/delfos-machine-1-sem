
using Microsoft.AspNetCore.Mvc;
using DelfosMachine.Models;
using System.Linq;

namespace DelfosMachine.Controllers
{
    public class MedicoController : Controller
    {
        private readonly ApplicationDbContext _context;

        public MedicoController(ApplicationDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var medicos = _context.Medicos.ToList();
            return View(medicos);
        }

        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Criar(Medico medico)
        {
            if (ModelState.IsValid)
            {
                _context.Medicos.Add(medico);
                _context.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(medico);
        }

        public IActionResult Editar(int id)
        {
            var medico = _context.Medicos.Find(id);
            if (medico == null)
            {
                return NotFound();
            }
            return View(medico);
        }

        [HttpPost]
        public IActionResult Editar(Medico medico)
        {
            if (ModelState.IsValid)
            {
                _context.Medicos.Update(medico);
                _context.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(medico);
        }

        public IActionResult Excluir(int id)
        {
            var medico = _context.Medicos.Find(id);
            if (medico != null)
            {
                _context.Medicos.Remove(medico);
                _context.SaveChanges();
            }
            return RedirectToAction(nameof(Index));
        }
    }
}
