using Microsoft.AspNetCore.Mvc;
using UserApi.Application.Services;
using UserApi.Domain;

namespace UserApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FeedbackController : ControllerBase
    {
        private readonly IFeedbackService _feedbackService;

        public FeedbackController(IFeedbackService feedbackService)
        {
            _feedbackService = feedbackService;
        }

        [HttpPost]
        public async Task<ActionResult<Feedback>> Create([FromBody] Feedback feedback)
        {
            await _feedbackService.Create(feedback);
            return CreatedAtAction(nameof(GetById), new { id = feedback.IdFeedback }, feedback);
        }

        [HttpGet]
        public async Task<ActionResult<List<Feedback>>> GetAll()
        {
            var feedbacks = await _feedbackService.GetAll();
            return Ok(feedbacks);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Feedback>> GetById(string id)
        {
            var feedback = await _feedbackService.GetById(id);
            if (feedback == null)
                return NotFound();

            return Ok(feedback);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Feedback>> Update(string id, [FromBody] Feedback tipoNotificacao)
        {
            if (id != tipoNotificacao.IdFeedback)
                return BadRequest("ID mismatch");

            var updatedFeedback = await _feedbackService.Update(tipoNotificacao);
            return Ok(updatedFeedback);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _feedbackService.Delete(id);
            return NoContent();
        }
    }
}
