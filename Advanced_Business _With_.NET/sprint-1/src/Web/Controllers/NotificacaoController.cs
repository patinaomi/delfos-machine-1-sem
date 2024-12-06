using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificacaoController : ControllerBase
    {
        private readonly INotificacaoService _notificacaoService;

        public NotificacaoController(INotificacaoService notificacaoService)
        {
            _notificacaoService = notificacaoService;
        }

        [HttpPost]
        public async Task<ActionResult<Notificacao>> Create([FromBody] Notificacao notificacao)
        {
            await _notificacaoService.Create(notificacao);
            return CreatedAtAction(nameof(GetById), new { id = notificacao.IdNotificacao }, notificacao);
        }

        [HttpGet]
        public async Task<ActionResult<List<Notificacao>>> GetAll()
        {
            var notificacaos = await _notificacaoService.GetAll();
            return Ok(notificacaos);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Notificacao>> GetById(string id)
        {
            var notificacao = await _notificacaoService.GetById(id);
            if (notificacao == null)
                return NotFound();

            return Ok(notificacao);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Notificacao>> Update(string id, [FromBody] Notificacao notificacao)
        {
            if (id != notificacao.IdNotificacao)
                return BadRequest("ID mismatch");

            var updatedNotificacao = await _notificacaoService.Update(notificacao);
            return Ok(updatedNotificacao);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _notificacaoService.Delete(id);
            return NoContent();
        }
    }
}
