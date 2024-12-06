using MongoDB.Driver;
using UserApi.Domain;
using UserApi.Domain.Repositories;
using Microsoft.Extensions.Options;
using MongoDB.Bson;
using UserApi.Domain.Entities;

namespace UserApi.Infrastructure.Repositories
{
    public class FormularioDetalhadoRepository : IFormularioDetalhadoRepository
    {
        private readonly IMongoCollection<FormularioDetalhado> _formularioDetalhadoCollection;

        public FormularioDetalhadoRepository(IOptions<ConfiguraracaoMongoDb> settings)
        {
            var mongoClient = new MongoClient(settings.Value.ConnectionString);
            var mongoDatabase = mongoClient.GetDatabase(settings.Value.DatabaseName);
            _formularioDetalhadoCollection = mongoDatabase.GetCollection<FormularioDetalhado>(settings.Value.FormularioDetalhadoCollectionName);
        }

        public async Task<FormularioDetalhado> Create(FormularioDetalhado formularioDetalhado)
        {
            await _formularioDetalhadoCollection.InsertOneAsync(formularioDetalhado);
            return formularioDetalhado;
        }

        public async Task<List<FormularioDetalhado>> GetAll()
        {
            return await _formularioDetalhadoCollection.Find(a => true).ToListAsync();
        }

        public async Task<FormularioDetalhado> GetById(string id)
        {
            return await _formularioDetalhadoCollection.Find(a => a.IdFormulario == id).FirstOrDefaultAsync();
        }

        public async Task Update(ObjectId id, FormularioDetalhado formularioDetalhado)
        {
            var update = Builders<FormularioDetalhado>.Update
                .Set(a => a.Historico_familiar, formularioDetalhado.Historico_familiar)
                .Set(a => a.Profissao, formularioDetalhado.Profissao)
                .Set(a => a.Data_ultima_atualizacao, formularioDetalhado.Data_ultima_atualizacao)
                .Set(a => a.Renda_mensal, formularioDetalhado.Renda_mensal)
                .Set(a => a.Historico_medico, formularioDetalhado.Historico_medico)
                .Set(a => a.Alergia, formularioDetalhado.Alergia)
                .Set(a => a.Condicao_preexistente, formularioDetalhado.Condicao_preexistente)
                .Set(a => a.Uso_medicamento, formularioDetalhado.Uso_medicamento)
                .Set(a => a.Familiar_com_doencas_dentarias, formularioDetalhado.Familiar_com_doencas_dentarias)
                .Set(a => a.Participacao_programa_preventivos, formularioDetalhado.Participacao_programa_preventivos)
                .Set(a => a.Contato_emergencial, formularioDetalhado.Contato_emergencial)
                .Set(a => a.Pesquisa_satisfacao, formularioDetalhado.Pesquisa_satisfacao)
                .Set(a => a.Frequencia_consulta_periodica, formularioDetalhado.Frequencia_consulta_periodica)
                .Set(a => a.Sinalizacao_risco, formularioDetalhado.Sinalizacao_risco)
                .Set(a => a.Historico_viagem, formularioDetalhado.Historico_viagem)
                .Set(a => a.Historico_mudanca_endereco, formularioDetalhado.Historico_mudanca_endereco)
                .Set(a => a.Preferencia_contato, formularioDetalhado.Preferencia_contato);

            await _formularioDetalhadoCollection.UpdateOneAsync(a => a.Id == id, update);
        }

        public async Task Delete(string id)
        {
            await _formularioDetalhadoCollection.DeleteOneAsync(a => a.IdFormulario == id);
        }
    }
}
