namespace UserApi.Domain
{
    public class ConfiguraracaoMongoDb
    {
        public string ConnectionString { get; set; } = null!;
        public string DatabaseName { get; set; } = null!;
        public string CadastroCollectionName { get; set; } = null!;
        public string ClienteCollectionName { get; set; } = null!;
        public string AgendaCollectionName { get; set; } = null!;

        public string ClinicaCollectionName { get; set; } = null!;
        public string ConsultaCollectionName { get; set; } = null!;
        public string DentistaCollectionName { get; set; } = null!;
        public string EstadoCivilCollectionName { get; set; } = null!;
        public string FeedbackCollectionName { get; set; } = null!;
        public string FormularioDetalhadoCollectionName { get; set; } = null!;
        public string NotificacaoCollectionName { get; set; } = null!;
        public string TipoNotificacaoCollectionName { get; set; } = null!;
        public string SinistroCollectionName { get; set; } = null!;
        public string LoginCollectionName { get; set; } = null!;
      
    }
}
