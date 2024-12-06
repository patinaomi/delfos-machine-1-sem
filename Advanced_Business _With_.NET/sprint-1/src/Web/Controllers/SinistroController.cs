using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SinistroController : ControllerBase
    {
        private readonly ISinistroService _sinistroService;

        public SinistroController(ISinistroService sinistroService)
        {
            _sinistroService = sinistroService;
        }

        [HttpPost]
        public async Task<ActionResult<Sinistro>> Create([FromBody] Sinistro sinistro)
        {
            await _sinistroService.Create(sinistro);
            return CreatedAtAction(nameof(GetById), new { id = sinistro.IdSinistro }, sinistro);
        }

        [HttpGet]
        public async Task<ActionResult<List<Sinistro>>> GetAll()
        {
            var sinistros = await _sinistroService.GetAll();
            return Ok(sinistros);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Sinistro>> GetById(string id)
        {
            var sinistro = await _sinistroService.GetById(id);
            if (sinistro == null)
                return NotFound();

            return Ok(sinistro);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Sinistro>> Update(string id, [FromBody] Sinistro sinistro)
        {
            if (id != sinistro.IdSinistro)
                return BadRequest("ID mismatch");

            var updatedSinistro = await _sinistroService.Update(sinistro);
            return Ok(updatedSinistro);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _sinistroService.Delete(id);
            return NoContent();
        }
    }
}
