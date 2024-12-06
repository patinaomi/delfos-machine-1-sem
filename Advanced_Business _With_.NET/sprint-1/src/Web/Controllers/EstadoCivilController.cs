using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstadoCivilController : ControllerBase
    {
        private readonly IEstadoCivilService _estadoCivilService;

        public EstadoCivilController(IEstadoCivilService estadoCivilService)
        {
            _estadoCivilService = estadoCivilService;
        }

        [HttpPost]
        public async Task<ActionResult<EstadoCivil>> Create([FromBody] EstadoCivil estadoCivil)
        {
            await _estadoCivilService.Create(estadoCivil);
            return CreatedAtAction(nameof(GetById), new { id = estadoCivil.IdEstadoCivil }, estadoCivil);
        }

        [HttpGet]
        public async Task<ActionResult<List<EstadoCivil>>> GetAll()
        {
            var estadoCivils = await _estadoCivilService.GetAll();
            return Ok(estadoCivils);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<EstadoCivil>> GetById(string id)
        {
            var estadoCivil = await _estadoCivilService.GetById(id);
            if (estadoCivil == null)
                return NotFound();

            return Ok(estadoCivil);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<EstadoCivil>> Update(string id, [FromBody] EstadoCivil estadoCivil)
        {
            if (id != estadoCivil.IdEstadoCivil)
                return BadRequest("ID mismatch");

            var updatedEstadoCivil = await _estadoCivilService.Update(estadoCivil);
            return Ok(updatedEstadoCivil);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _estadoCivilService.Delete(id);
            return NoContent();
        }
    }
}
