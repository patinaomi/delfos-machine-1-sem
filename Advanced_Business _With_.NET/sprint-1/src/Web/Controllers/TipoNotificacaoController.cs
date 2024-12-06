using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TipoNotificacaoController : ControllerBase
    {
        private readonly ITipoNotificacaoService _tipoNotificacaoService;

        public TipoNotificacaoController(ITipoNotificacaoService tipoNotificacaoService)
        {
            _tipoNotificacaoService = tipoNotificacaoService;
        }

        [HttpPost]
        public async Task<ActionResult<TipoNotificacao>> Create([FromBody] TipoNotificacao tipoNotificacao)
        {
            await _tipoNotificacaoService.Create(tipoNotificacao);
            return CreatedAtAction(nameof(GetById), new { id = tipoNotificacao.IdTipoNotificacao }, tipoNotificacao);
        }

        [HttpGet]
        public async Task<ActionResult<List<TipoNotificacao>>> GetAll()
        {
            var tipoNotificacaos = await _tipoNotificacaoService.GetAll();
            return Ok(tipoNotificacaos);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TipoNotificacao>> GetById(string id)
        {
            var tipoNotificacao = await _tipoNotificacaoService.GetById(id);
            if (tipoNotificacao == null)
                return NotFound();

            return Ok(tipoNotificacao);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<TipoNotificacao>> Update(string id, [FromBody] TipoNotificacao tipoNotificacao)
        {
            if (id != tipoNotificacao.IdTipoNotificacao)
                return BadRequest("ID mismatch");

            var updatedTipoNotificacao = await _tipoNotificacaoService.Update(tipoNotificacao);
            return Ok(updatedTipoNotificacao);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _tipoNotificacaoService.Delete(id);
            return NoContent();
        }
    }
}
