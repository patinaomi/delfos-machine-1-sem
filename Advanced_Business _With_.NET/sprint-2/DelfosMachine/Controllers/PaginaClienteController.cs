using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DelfosMachine.Controllers
{
    // usar essa tag para bloquear o acesso de quem não estiver logado.
    [Authorize]
    public class PaginaClienteController : Controller
    {
   
        public IActionResult Index()
        {
            return View();
        }
    }
}
