using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;
using UserApi.Domain.Entities;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FormularioDetalhadoController : ControllerBase
    {
        private readonly IFormularioDetalhadoService _formularioDetalhadoService;

        public FormularioDetalhadoController(IFormularioDetalhadoService formularioDetalhadoService)
        {
            _formularioDetalhadoService = formularioDetalhadoService;
        }

        [HttpPost]
        public async Task<ActionResult<FormularioDetalhado>> Create([FromBody] FormularioDetalhado formularioDetalhado)
        {
            await _formularioDetalhadoService.Create(formularioDetalhado);
            return CreatedAtAction(nameof(GetById), new { id = formularioDetalhado.IdFormulario }, formularioDetalhado);
        }

        [HttpGet]
        public async Task<ActionResult<List<FormularioDetalhado>>> GetAll()
        {
            var formularioDetalhados = await _formularioDetalhadoService.GetAll();
            return Ok(formularioDetalhados);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<FormularioDetalhado>> GetById(string id)
        {
            var formularioDetalhado = await _formularioDetalhadoService.GetById(id);
            if (formularioDetalhado == null)
                return NotFound();

            return Ok(formularioDetalhado);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<FormularioDetalhado>> Update(string id, [FromBody] FormularioDetalhado formularioDetalhado)
        {
            if (id != formularioDetalhado.IdFormulario)
                return BadRequest("ID mismatch");

            var updatedFormularioDetalhado = await _formularioDetalhadoService.Update(formularioDetalhado);
            return Ok(updatedFormularioDetalhado);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _formularioDetalhadoService.Delete(id);
            return NoContent();
        }
    }
}
