using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgendaController : ControllerBase
    {
        private readonly IAgendaService _agendaService;

        public AgendaController(IAgendaService agendaService)
        {
            _agendaService = agendaService;
        }

        [HttpPost]
        public async Task<ActionResult<Agenda>> Create([FromBody] Agenda agenda)
        {
            await _agendaService.Create(agenda);
            return CreatedAtAction(nameof(GetById), new { id = agenda.IdAgenda }, agenda);
        }

        [HttpGet]
        public async Task<ActionResult<List<Agenda>>> GetAll()
        {
            var agendas = await _agendaService.GetAll();
            return Ok(agendas);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Agenda>> GetById(string id)
        {
            var agenda = await _agendaService.GetById(id);
            if (agenda == null)
                return NotFound();

            return Ok(agenda);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Agenda>> Update(string id, [FromBody] Agenda agenda)
        {
            if (id != agenda.IdAgenda)
                return BadRequest("ID mismatch");

            var updatedAgenda = await _agendaService.Update(agenda);
            return Ok(updatedAgenda);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _agendaService.Delete(id);
            return NoContent();
        }
    }
}
