using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DentistaController : ControllerBase
    {
        private readonly IDentistaService _dentistaService;

        public DentistaController(IDentistaService dentistaService)
        {
            _dentistaService = dentistaService;
        }

        [HttpPost]
        public async Task<ActionResult<Dentista>> Create([FromBody] Dentista dentista)
        {
            await _dentistaService.Create(dentista);
            return CreatedAtAction(nameof(GetById), new { id = dentista.IdDentista }, dentista);
        }

        [HttpGet]
        public async Task<ActionResult<List<Dentista>>> GetAll()
        {
            var dentistas = await _dentistaService.GetAll();
            return Ok(dentistas);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Dentista>> GetById(string id)
        {
            var dentista = await _dentistaService.GetById(id);
            if (dentista == null)
                return NotFound();

            return Ok(dentista);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Dentista>> Update(string id, [FromBody] Dentista dentista)
        {
            if (id != dentista.IdDentista)
                return BadRequest("ID mismatch");

            var updatedDentista = await _dentistaService.Update(dentista);
            return Ok(updatedDentista);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _dentistaService.Delete(id);
            return NoContent();
        }
    }
}
