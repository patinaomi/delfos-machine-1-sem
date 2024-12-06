using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ClinicaController : ControllerBase
    {
        private readonly IClinicaService _clinicaService;

        public ClinicaController(IClinicaService clinicaService)
        {
            _clinicaService = clinicaService;
        }

        [HttpPost]
        public async Task<ActionResult<Clinica>> Create([FromBody] Clinica clinica)
        {
            await _clinicaService.Create(clinica);
            return CreatedAtAction(nameof(GetById), new { id = clinica.IdClinica }, clinica);
        }

        [HttpGet]
        public async Task<ActionResult<List<Clinica>>> GetAll()
        {
            var clinicas = await _clinicaService.GetAll();
            return Ok(clinicas);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Clinica>> GetById(string id)
        {
            var clinica = await _clinicaService.GetById(id);
            if (clinica == null)
                return NotFound();

            return Ok(clinica);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Clinica>> Update(string id, [FromBody] Clinica clinica)
        {
            if (id != clinica.IdClinica)
                return BadRequest("ID mismatch");

            var updatedClinica = await _clinicaService.Update(clinica);
            return Ok(updatedClinica);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _clinicaService.Delete(id);
            return NoContent();
        }
    }
}
