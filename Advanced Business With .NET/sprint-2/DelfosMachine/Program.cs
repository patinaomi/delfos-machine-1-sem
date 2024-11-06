using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using MongoDB.Driver;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using DelfosMachine.Domain;
using DelfosMachine.Application.Services;
using DelfosMachine.Domain.Repositories;
using MongoDB.Bson;
using DelfosMachine.Infrastructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Configuração do MongoDB
builder.Services.Configure<ConfiguraracaoMongoDb>(builder.Configuration.GetSection("ConfiguraracaoMongoDb"));

// Registra o cliente MongoDB como singleton
builder.Services.AddTransient<IMongoClient>(sp =>   
{
    var settings = sp.GetRequiredService<IOptions<ConfiguraracaoMongoDb>>().Value;
    return new MongoClient(settings.ConnectionString);
});

// Registrar os serviços necessários com ciclo de vida Transient

//Cadastro
builder.Services.AddTransient<ICadastroService, CadastroService>();
builder.Services.AddTransient<ICadastroRepository, CadastroRepository>();

// Cliente
builder.Services.AddTransient<IClienteService, ClienteService>();
builder.Services.AddTransient<IClienteRepository, ClienteRepository>();

// Agenda
builder.Services.AddTransient<IAgendaService, AgendaService>();
builder.Services.AddTransient<IAgendaRepository, AgendaRepository>();

// Clinica
builder.Services.AddTransient<IClinicaService, ClinicaService>();
builder.Services.AddTransient<IClinicaRepository, ClinicaRepository>();

// Dentista
builder.Services.AddTransient<IDentistaService, DentistaService>();
builder.Services.AddTransient<IDentistaRepository, DentistaRepository>();

// Consulta
builder.Services.AddTransient<IConsultaService, ConsultaService>();
builder.Services.AddTransient<IConsultaRepository, ConsultaRepository>();

// Estado Civil
builder.Services.AddTransient<IEstadoCivilService, EstadoCivilService>();
builder.Services.AddTransient<IEstadoCivilRepository, EstadoCivilRepository>();

// Tipo Notificação
builder.Services.AddTransient<ITipoNotificacaoService, TipoNotificacaoService>();
builder.Services.AddTransient<ITipoNotificacaoRepository, TipoNotificacaoRepository>();

// Feedback
builder.Services.AddTransient<IFeedbackService, FeedbackService>();
builder.Services.AddTransient<IFeedbackRepository, FeedbackRepository>();

// Notificação
builder.Services.AddTransient<INotificacaoService, NotificacaoService>();
builder.Services.AddTransient<INotificacaoRepository, NotificacaoRepository>();

// Formulário Detalhado
builder.Services.AddTransient<IFormularioDetalhadoService, FormularioDetalhadoService>();
builder.Services.AddTransient<IFormularioDetalhadoRepository, FormularioDetalhadoRepository>();

// Sinistro
builder.Services.AddTransient<ISinistroService, SinistroService>();
builder.Services.AddTransient<ISinistroRepository, SinistroRepository>();

// Logs Logins efetuados
builder.Services.AddTransient<ILoginService, LoginService>();
builder.Services.AddTransient<ILoginRepository, LoginRepository>();

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
        Description = "Esta é uma API desenvolvida para o projeto do Challenge da OdontoPrev...",
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

// Configurando portas para diferentes testes
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(5001); // Porta principal para o serviço
    options.ListenAnyIP(5002); // Outra porta para testes
});

var app = builder.Build();

// Testa a conexão ao MongoDB
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var mongoClient = services.GetRequiredService<IMongoClient>();
    try
    {
        var settings = services.GetRequiredService<IOptions<ConfiguraracaoMongoDb>>().Value;
        var database = mongoClient.GetDatabase(settings.DatabaseName);
        var collection = database.GetCollection<BsonDocument>("test");
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

    // novo
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();

// novo
// Necessário para servir arquivos estáticos (CSS, JS, imagens, etc.)
app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
app.UseCors("AllowAllOrigins");

// Mapeamento de controladores para APIs
app.MapControllers();

// novo MVC
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
