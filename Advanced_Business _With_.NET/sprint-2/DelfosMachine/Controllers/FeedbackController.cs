using DelfosMachine.Models;
using Microsoft.AspNetCore.Mvc;

namespace DelfosMachine.Controllers
{
    public class FeedbackController : Controller
    {
        private readonly ApplicationDbContext _context;

        public FeedbackController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Criar(Feedback feedback)
        {
            if (ModelState.IsValid)
            {
                _context.Feedback.Add(feedback);
                _context.SaveChanges();


                TempData["Mensagem"] = $"Feedback cadastrado com sucesso! Cliente: {feedback.IdCliente}, Especialista: {feedback.IdEspecialista}, Clínica: {feedback.IdClinica}, Nota: {feedback.Nota}, Comentário: {feedback.Comentario}";

                return RedirectToAction("Mensagem");
            }

            return View(feedback);
        }

        public IActionResult Mensagem()
        {
            return View();
        }
    }
}
