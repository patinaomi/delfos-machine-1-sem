using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using MongoDB.Driver;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using UserApi.Domain;
using UserApi.Application.Services;
using UserApi.Domain.Repositories;
using MongoDB.Bson;
using UserApi.Infrastructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Configuração do MongoDB
builder.Services.Configure<ConfiguraracaoMongoDb>(builder.Configuration.GetSection("ConfiguraracaoMongoDb"));

// Registra o cliente MongoDB como singleton
builder.Services.AddSingleton<IMongoClient>(sp =>   
{
    var settings = sp.GetRequiredService<IOptions<ConfiguraracaoMongoDb>>().Value;
    return new MongoClient(settings.ConnectionString);
});

// Registrar os serviços necessários

//Cadastro
builder.Services.AddSingleton<ICadastroService, CadastroService>();
builder.Services.AddSingleton<ICadastroRepository, CadastroRepository>();

// Cliente
builder.Services.AddSingleton<IClienteService, ClienteService>();
builder.Services.AddSingleton<IClienteRepository, ClienteRepository>();

// Agenda
builder.Services.AddSingleton<IAgendaService, AgendaService>();
builder.Services.AddSingleton<IAgendaRepository, AgendaRepository>();

// Clinica
builder.Services.AddSingleton<IClinicaService, ClinicaService>();
builder.Services.AddSingleton<IClinicaRepository, ClinicaRepository>();

// Dentista
builder.Services.AddSingleton<IDentistaService, DentistaService>();
builder.Services.AddSingleton<IDentistaRepository, DentistaRepository>();

// Consulta
builder.Services.AddSingleton<IConsultaService, ConsultaService>();
builder.Services.AddSingleton<IConsultaRepository, ConsultaRepository>();

// Estado Civil
builder.Services.AddSingleton<IEstadoCivilService, EstadoCivilService>();
builder.Services.AddSingleton<IEstadoCivilRepository, EstadoCivilRepository>();

// Tipo Notificação
builder.Services.AddSingleton<ITipoNotificacaoService, TipoNotificacaoService>();
builder.Services.AddSingleton<ITipoNotificacaoRepository, TipoNotificacaoRepository>();

// Feedback
builder.Services.AddSingleton<IFeedbackService, FeedbackService>();
builder.Services.AddSingleton<IFeedbackRepository, FeedbackRepository>();

// Notificação
builder.Services.AddSingleton<INotificacaoService, NotificacaoService>();
builder.Services.AddSingleton<INotificacaoRepository, NotificacaoRepository>();

// Formulário Detalhado
builder.Services.AddSingleton<IFormularioDetalhadoService, FormularioDetalhadoService>();
builder.Services.AddSingleton<IFormularioDetalhadoRepository, FormularioDetalhadoRepository>();

// Sinistro
builder.Services.AddSingleton<ISinistroService, SinistroService>();
builder.Services.AddSingleton<ISinistroRepository, SinistroRepository>();

// Logs Logins efetuados
builder.Services.AddSingleton<ILoginService, LoginService>();
builder.Services.AddSingleton<ILoginRepository, LoginRepository>();


// Adicionar configuração de autenticação JWT
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        var jwtKey = builder.Configuration["Jwt:Key"];
        if (string.IsNullOrEmpty(jwtKey))
        {
            throw new ArgumentNullException("JWT Key not found in configuration.");
        }

        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = false,
            ValidateAudience = false,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(jwtKey))
        };
    });

builder.Services.AddLogging();
builder.Services.AddControllers();

// Adicionar configuração de CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins",
        builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyMethod()
                   .AllowAnyHeader();
        });
});

// Configuração do Swagger/OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo 
    { 
        Title = "Minha API", 
        Version = "v1",
        Description = "Esta é uma API desenvolvida para o projeto do Challenge da OdontoPrev. O sistema permite o cadastro e gerenciamento de usuários com autenticação baseada em JWT. Para mais informações, você pode acessar o vídeo da aplicação [aqui](https://link-do-video.com). Definição do projeto: Será criado uma aplicação que vai realizar sugestão de consultas ao cliente por meio de uma agenda eletrônica que vai se basear em três pilares, sendo 1. Local de preferência do cliente, 2. Qualidade (avaliando as pesquisas de satisfação e 3. Baixo custo.)",
        Contact = new OpenApiContact
        {
            Name = "Claudio Silva Bispo e Patricia Naomi",
            Email = "rm553472@fiap.com.br, rm552981@fiap.com.br",
            Url = new Uri("https://github.com/Claudio-Silva-Bispo")
        },
        License = new OpenApiLicense
        {
            Name = "Delfos Machine Group",
            Url = new Uri("https://github.com/Claudio-Silva-Bispo")
        }
    });
});

builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(3001); // Escolha uma porta diferente que não esteja em uso
});

var app = builder.Build();

// Testa a conexão ao MongoDB
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var mongoClient = services.GetRequiredService<IMongoClient>();
    try
    {
        // Aqui você pode realizar uma operação simples para verificar a conexão
        var settings = services.GetRequiredService<IOptions<ConfiguraracaoMongoDb>>().Value;
        var database = mongoClient.GetDatabase(settings.DatabaseName); // Usando o nome do banco configurado
        var collection = database.GetCollection<BsonDocument>("test"); // Substitua "test" pelo nome de uma coleção existente
        var documentCount = await collection.CountDocumentsAsync(new BsonDocument());
        
        Console.WriteLine($"Conexão ao MongoDB estabelecida com sucesso. {documentCount} documentos encontrados na coleção.");
    }
    catch (Exception ex)
    {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "Erro ao conectar ao MongoDB.");
    }
}

// Configura o pipeline de requisições HTTP
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication(); // Certifique-se de adicionar UseAuthentication antes de UseAuthorization
app.UseAuthorization();
app.UseCors("AllowAllOrigins");
app.MapControllers();
app.Run();
