using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace UserApi.Domain.Entities
{
    public class FormularioDetalhado
    {
        [BsonId]
        public ObjectId Id { get; set; }
        public string? IdFormulario { get; set; }
        public string IdCliente { get; set; } = null!;
        public string IdEstadoCivil { get; set; } = null!;
        public string Historico_familiar { get; set; } = null!;
        public string Profissao { get; set; } = null!;
        public DateTime Data_ultima_atualizacao { get; set; }

        public string Data => ConvertToSaoPauloTime(Data_ultima_atualizacao).ToString("yyyy-MM-dd");

        public string Hora => ConvertToSaoPauloTime(Data_ultima_atualizacao).ToString("HH:mm:ss");

        private DateTime ConvertToSaoPauloTime(DateTime utcDateTime)
        {
            TimeZoneInfo saoPauloTimeZone = TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time");
            return TimeZoneInfo.ConvertTimeFromUtc(utcDateTime, saoPauloTimeZone);
        }

        public float Renda_mensal { get; set; }
        public string Historico_medico { get; set; } = null!;
        public string Alergia { get; set; } = null!;
        public string Condicao_preexistente { get; set; } = null!;
        public string Uso_medicamento { get; set; } = null!;
        public string Familiar_com_doencas_dentarias { get; set; } = null!;
        public string Participacao_programa_preventivos { get; set; } = null!;
        public string Contato_emergencial { get; set; } = null!;
        public string Pesquisa_satisfacao { get; set; } = null!;
        public string Frequencia_consulta_periodica { get; set; } = null!;
        public string Sinalizacao_risco { get; set; } = null!;
        public string Historico_viagem { get; set; } = null!;
        public string Historico_mudanca_endereco { get; set; } = null!;
        public string Preferencia_contato { get; set; } = null!;

    }
}
