using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ConsultaController : ControllerBase
    {
        private readonly IConsultaService _consultaService;

        public ConsultaController(IConsultaService consultaService)
        {
            _consultaService = consultaService;
        }

        [HttpPost]
        public async Task<ActionResult<Consulta>> Create([FromBody] Consulta consulta)
        {
            await _consultaService.Create(consulta);
            return CreatedAtAction(nameof(GetById), new { id = consulta.IdConsulta }, consulta);
        }

        [HttpGet]
        public async Task<ActionResult<List<Consulta>>> GetAll()
        {
            var consultas = await _consultaService.GetAll();
            return Ok(consultas);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Consulta>> GetById(string id)
        {
            var consulta = await _consultaService.GetById(id);
            if (consulta == null)
                return NotFound();

            return Ok(consulta);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Consulta>> Update(string id, [FromBody] Consulta consulta)
        {
            if (id != consulta.IdConsulta)
                return BadRequest("ID mismatch");

            var updatedConsulta = await _consultaService.Update(consulta);
            return Ok(updatedConsulta);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _consultaService.Delete(id);
            return NoContent();
        }
    }
}
