using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;

namespace UserApi.Infrastructure.Repositories
{
    public class LoginRepository : ILoginRepository
    {
        private readonly IMongoCollection<Login> _loginCollection;

        public LoginRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _loginCollection = mongoDatabase.GetCollection<Login>(settings.Value.LoginCollectionName);
        }

        public async Task<Login> Create(Login login)
        {
            await _loginCollection.InsertOneAsync(login);
            return login;
        }

        public async Task<List<Login>> GetAll()
        {
            return await _loginCollection.Find(a => true).ToListAsync();
        }

        public async Task<Login> GetById(string id)
        {
            return await _loginCollection.Find(a => a.IdLogin == id).FirstOrDefaultAsync();
        }

    }
}
