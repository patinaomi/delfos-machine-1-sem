using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly ILoginService _loginService;

        public LoginController(ILoginService loginService)
        {
            _loginService = loginService;
        }

        [HttpPost]
        public async Task<ActionResult<Login>> Create([FromBody] Login login)
        {
            await _loginService.Create(login);
            return CreatedAtAction(nameof(GetById), new { id = login.IdLogin }, login);
        }

        [HttpGet]
        public async Task<ActionResult<List<Login>>> GetAll()
        {
            var logins = await _loginService.GetAll();
            return Ok(logins);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Login>> GetById(string id)
        {
            var login = await _loginService.GetById(id);
            if (login == null)
                return NotFound();

            return Ok(login);
        }

    }
}
