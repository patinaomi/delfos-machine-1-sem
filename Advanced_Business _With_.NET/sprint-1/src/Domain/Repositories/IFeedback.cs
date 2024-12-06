
using MongoDB.Bson;

namespace UserApi.Domain.Repositories
{
    public interface IFeedbackRepository
    {
        Task<Feedback> Create(Feedback feedback);
        Task<List<Feedback>> GetAll();
        Task<Feedback> GetById(string id);
        Task Update(ObjectId id, Feedback feedback);
        Task Delete(string id);
    }
}
