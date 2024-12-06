using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class FeedbackRepository : IFeedbackRepository
    {
        private readonly IMongoCollection<Feedback> _feedbackCollection;

        public FeedbackRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _feedbackCollection = mongoDatabase.GetCollection<Feedback>(settings.Value.FeedbackCollectionName);
        }

        public async Task<Feedback> Create(Feedback feedback)
        {
            await _feedbackCollection.InsertOneAsync(feedback);
            return feedback;
        }

        public async Task<List<Feedback>> GetAll()
        {
            return await _feedbackCollection.Find(a => true).ToListAsync();
        }

        public async Task<Feedback> GetById(string id)
        {
            return await _feedbackCollection.Find(a => a.IdFeedback == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, Feedback feedback)
        {
            var update = Builders<Feedback>.Update
                .Set(a => a.Nota, feedback.Nota)
                .Set(a => a.Comentario, feedback.Comentario);

            await _feedbackCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _feedbackCollection.DeleteOneAsync(a => a.IdFeedback == id);
        }
    }
}
