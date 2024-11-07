using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DelfosMachine.Models;
using System.Security.Claims;
using System.Threading.Tasks;

namespace DelfosMachine.Controllers
{
    public class LoginController : Controller
    {
        private readonly ApplicationDbContext _context;

        public LoginController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Login/Logar
        public IActionResult Logar()
        {
            return View();
        }

        // POST: Login/Logar
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logar(Login model)
        {
            if (ModelState.IsValid)
            {
                var user = await _context.Clientes
                    .FirstOrDefaultAsync(c => c.Email == model.Email && c.Senha == model.Senha);

                if (user != null && user.Nome != null && user.Email != null)
                {
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, user.Nome),
                        new Claim(ClaimTypes.Email, user.Email),
                        // Adiciona o ID do usuário como uma reivindicação para fazer alterações no cadastro
                        new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()) 
                    };

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));

                    return RedirectToAction("Hero", "Home");
                }
                else
                {
                    return RedirectToAction("MensagemErro");
                }
            }
            return View(model);
        }

        // GET: Login/MensagemErro
        public IActionResult MensagemErro()
        {
            return View();
        }

        // GET: Login/Logout
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Logar", "Login");
        }
    }
}
