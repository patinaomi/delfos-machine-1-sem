
using UserApi.Domain;
using UserApi.Domain.Repositories;

namespace UserApi.Application.Services
{
    public class FeedbackService : IFeedbackService
    {
        private readonly IFeedbackRepository _feedbackRepository;

        public FeedbackService(IFeedbackRepository feedbackRepository)
        {
            _feedbackRepository = feedbackRepository;
        }

        public async Task<Feedback> Create(Feedback feedback)
        {
            feedback.IdFeedback = Guid.NewGuid().ToString();

            await _feedbackRepository.Create(feedback);
            return feedback; 
        }

        public async Task<List<Feedback>> GetAll()
        {
            return await _feedbackRepository.GetAll();
        }

        public async Task<Feedback> GetById(string id)
        {
            return await _feedbackRepository.GetById(id);
        }

        public async Task<Feedback> Update(Feedback feedback)
        {
            if (string.IsNullOrEmpty(feedback.IdFeedback))
            {
                throw new ArgumentNullException(nameof(feedback.IdFeedback), "O ID do Feedback não pode ser nulo ou vazio.");
            }

            var existingFeedback = await _feedbackRepository.GetById(feedback.IdFeedback);
            if (existingFeedback == null)
            {
                throw new Exception("Agenda não encontrada");
            }

            await _feedbackRepository.Update(feedback.Id, feedback); 
            return feedback; 
        }

        public async Task Delete(string id)
        {
            await _feedbackRepository.Delete(id);
        }
    }
}
