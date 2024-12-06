using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DelfosMachine.Controllers
{   
    [Authorize]
    public class PaginaClinicaController : Controller
    {
   
        public IActionResult Index()
        {
            return View();
        }
    }
}
