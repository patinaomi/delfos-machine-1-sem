

# Etapas do projeto

1. No terminal do VS Code, execute o comando:
```bash
    dotnet new mvc -n DelfosMachine
```

2. Navegar até a pasta
```bash
    cd DelfosMachine
```  

3. Instale o pacote NuGet para Oracle:
```bash
    dotnet add package Oracle.ManagedDataAccess.Core
    dotnet add package Oracle.EntityFrameworkCore
```

## Agora vamos configurar a string de conexão com o banco de dados Oracle

1. Abra o arquivo appsettings.json no seu projeto.

2. Adicione a string de conexão dentro do objeto ConnectionStrings. Deve ficar algo assim:
```bash
    {
        "ConnectionStrings": {
        "Oracle": "User Id=seu_usuario;Password=sua_senha;Data Source=seu_data_source"}
    }

```

## Crie uma nova pasta chamada Data dentro do seu projeto.

Dentro da pasta Data, crie um arquivo chamado ApplicationDbContext.cs.
Adicione o seguinte código ao ApplicationDbContext.cs

```bash

    using DelfosMachine.Models;
    using Microsoft.EntityFrameworkCore;

    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Cliente> Clientes { get; set; }
    }
```

## Abra o arquivo Startup.cs.
Adicione o seguinte código no método ConfigureService

```bash
    services.AddDbContext<ApplicationDbContext>(options =>
    options.UseOracle(Configuration.GetConnectionString("OracleConnection")));
```

## Vamos adicionar o Swagger ao projeto:
```bash
    dotnet add package Swashbuckle.AspNetCore
    dotnet add package Swashbuckle.AspNetCore.Annotations

    
```

## Configure o Swagger no Program.cs
```bash
    services.AddSwaggerGen();
```

## Instalar
```bash
    dotnet add package Microsoft.EntityFrameworkCore
    dotnet add package Microsoft.EntityFrameworkCore.Design
    dotnet add package Microsoft.EntityFrameworkCore.Tools
```

## Criar a Model exemplo
**Já possui validações básicas no modelo**

```bash
    using System.ComponentModel.DataAnnotations;
    namespace DelfosMachine.Models;

    public class Cliente
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "O nome é obrigatório")]
        [StringLength(100, ErrorMessage = "O nome deve ter no máximo 50 caracteres")]
        public string? Nome { get; set; }

        [Required(ErrorMessage = "O email é obrigatório")]
        [EmailAddress(ErrorMessage = "Email inválido")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "O telefone é obrigatório")]
        [Phone(ErrorMessage = "Telefone inválido")]
        public string? Telefone { get; set; }
    }
```

## Controller exemplo
**Com todas as anotações necessárias**

```bash
    using DelfosMachine.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using Swashbuckle.AspNetCore.Annotations;
    using System.Linq;
    using System.Threading.Tasks;

    [Route("api/[controller]")]
    public class ClienteController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ClienteController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet("ConsultarTodos")]
        [SwaggerOperation(Summary = "Consulta todos os clientes", Description = "Retorna uma lista de todos os clientes cadastrados.")]
        public async Task<IActionResult> ConsultarTodos()
        {
            return View(await _context.Clientes.ToListAsync());
        }

        [HttpGet("ConsultarId/{id}")]
        [SwaggerOperation(Summary = "Consulta um cliente pelo ID", Description = "Retorna os detalhes de um cliente específico.")]
        public async Task<IActionResult> ConsultarId(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var cliente = await _context.Clientes
                .FirstOrDefaultAsync(m => m.Id == id);
            if (cliente == null)
            {
                return NotFound();
            }

            return View(cliente);
        }

        [HttpGet("Criar")]
        [SwaggerOperation(Summary = "Cria um novo cliente", Description = "Exibe o formulário para criar um novo cliente.")]
        public IActionResult Criar()
        {
            return View();
        }

        [HttpPost("Criar")]
        [ValidateAntiForgeryToken]
        [SwaggerOperation(Summary = "Cria um novo cliente", Description = "Salva os dados de um novo cliente no banco de dados.")]
        public async Task<IActionResult> Criar([Bind("Id,Nome,Email,Telefone")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                _context.Add(cliente);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(ConsultarTodos));
            }
            return View(cliente);
        }

        [HttpGet("Atualizar/{id}")]
        [SwaggerOperation(Summary = "Atualiza um cliente existente", Description = "Exibe o formulário para atualizar um cliente.")]
        public async Task<IActionResult> Atualizar(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var cliente = await _context.Clientes.FindAsync(id);
            if (cliente == null)
            {
                return NotFound();
            }
            return View(cliente);
        }

        [HttpPost("Atualizar/{id}")]
        [ValidateAntiForgeryToken]
        [SwaggerOperation(Summary = "Atualiza um cliente existente", Description = "Salva as alterações de um cliente no banco de dados.")]
        public async Task<IActionResult> Atualizar(int id, [Bind("Id,Nome,Email,Telefone")] Cliente cliente)
        {
            if (id != cliente.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(cliente);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ClienteExiste(cliente.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(ConsultarTodos));
            }
            return View(cliente);
        }

        [HttpGet("Deletar/{id}")]
        [SwaggerOperation(Summary = "Deleta um cliente", Description = "Exibe a confirmação para deletar um cliente.")]
        public async Task<IActionResult> Deletar(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var cliente = await _context.Clientes
                .FirstOrDefaultAsync(m => m.Id == id);
            if (cliente == null)
            {
                return NotFound();
            }

            return View(cliente);
        }

        [HttpPost("Deletar/{id}")]
        [ValidateAntiForgeryToken]
        [SwaggerOperation(Summary = "Confirma a exclusão de um cliente", Description = "Remove um cliente do banco de dados.")]
        public async Task<IActionResult> DeletarConfirmado(int id)
        {
            var cliente = await _context.Clientes.FindAsync(id);
            if (cliente == null)
            {
                return NotFound();
            }

            _context.Clientes.Remove(cliente);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ConsultarTodos));
        }

        private bool ClienteExiste(int id)
        {
            return _context.Clientes.Any(e => e.Id == id);
        }
    }
```

## Depois de criar as Models e Controller, precisamos criar as Migrations

1. Instalar a ferramenta dotnet-ef
```bash
    dotnet tool install --global dotnet-ef
```

2. Verificar se a instalação foi bem-sucedida
```bash
    dotnet ef
```

3. Se ainda não tiver o Microsoft.EntityFrameworkCore.Design, que é necessário para rodar migrações, execute também:
```bash
    dotnet add package Microsoft.EntityFrameworkCore.Design
```

4. Gere as migrações:
```bash
    dotnet ef migrations add Inicio
```
**Sempre mudar o nome final, ao cadastrar uma nova tabela**

5. Aplique as migrações:
```bash
    dotnet ef database update
```

5. Se precisar listar as Migrations
```bash
    dotnet ef migrations list
```

6. Remova a Migration se houver duplicados
```bash
    dotnet ef migrations remove
```

## Configurar o Program.cs

```bash
    using Microsoft.AspNetCore.Builder;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Hosting;
    using Microsoft.EntityFrameworkCore;
    using Swashbuckle.AspNetCore.SwaggerGen;


    var builder = WebApplication.CreateBuilder(args);

    // Add services to the container.
    builder.Services.AddControllersWithViews();

    // Adicione o serviço do Swagger
    builder.Services.AddSwaggerGen();

    builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseOracle(builder.Configuration.GetConnectionString("Oracle")));

    var app = builder.Build();

    // Aplica as migrações pendentes e cria o banco se necessário. Melhor do que eu esperar ter a tabela.
    using (var scope = app.Services.CreateScope())
    {
        var context = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        // Aplica migrações e cria o banco se não existir
        context.Database.Migrate();  
    }


    // Configure the HTTP request pipeline.
    if (!app.Environment.IsDevelopment())
    {
        app.UseExceptionHandler("/Home/Error");
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }

    app.UseHttpsRedirection();
    app.UseStaticFiles();

    app.UseRouting();

    app.UseAuthorization();

    // Configure o Swagger
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Minha API V1");
        c.RoutePrefix = string.Empty;
    });

    app.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");


    app.Run();
```

# Executar a aplicação e testar
```bash
    dotnet build
```

```bash
    dotnet run
```