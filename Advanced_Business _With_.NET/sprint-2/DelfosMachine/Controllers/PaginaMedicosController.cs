using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DelfosMachine.Controllers
{
    public class PaginaMedicosController : Controller
    {
   
        public IActionResult Index()
        {
            return View();
        }
    }
}
