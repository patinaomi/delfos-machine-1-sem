using Microsoft.Extensions.Options;
using MongoDB.Driver;
using UserApi.Domain.Entities;
using UserApi.Domain.Repositories;
using UserApi.Domain;

public class CadastroRepository : ICadastroRepository
{
    private readonly IMongoCollection<Cadastro> _cadastroCollection;

    public CadastroRepository(IOptions<ConfiguraracaoMongoDb> settings)
    {
        var mongoClient = new MongoClient(settings.Value.ConnectionString);
        var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
        _cadastroCollection = mongoDatabase.GetCollection<Cadastro>(settings.Value.CadastroCollectionName);
    }

    public async Task Create(Cadastro cadastro)
    {
        await _cadastroCollection.InsertOneAsync(cadastro);
    }
}
