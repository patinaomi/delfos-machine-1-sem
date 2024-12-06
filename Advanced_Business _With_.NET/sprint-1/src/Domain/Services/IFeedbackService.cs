
using UserApi.Domain;

namespace UserApi.Application.Services
{
    public interface IFeedbackService
    {
        Task<Feedback> Create(Feedback feedback);
        Task<List<Feedback>> GetAll();
        Task<Feedback> GetById(string id);
        Task<Feedback> Update(Feedback feedback);
        Task Delete(string id);
    }
}
