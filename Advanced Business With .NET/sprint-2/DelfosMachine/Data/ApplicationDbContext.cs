using DelfosMachine.Models;
using Microsoft.EntityFrameworkCore;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Cliente> Clientes { get; set; }
    public DbSet<PreferenciaCliente> PreferenciasClientes { get; set; }
    public DbSet<EnderecoPreferencia> EnderecoPreferencia { get; set; }
    public DbSet<HorarioPreferencia> PreferenciaHorario { get; set; }
    public DbSet<TurnoPreferencia> Turno { get; set; }
    public DbSet<DiaSemanaPreferencia> PreferenciaDia  { get; set; }
    public DbSet<RotinaCuidadoCliente> RotinaCuidado  { get; set; }
    public DbSet<SugestaoConsulta> SugestaoConsulta  { get; set; }
    public DbSet<Feedback> Feedback  { get; set; }
    public DbSet<ServicosPendentes> ServicosPendentes { get; set; }
    public DbSet<Medico> Medicos { get; set; }
    public DbSet<Especialista> Especialista { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<SugestaoConsulta>()
            .ToTable("sugestaoConsulta");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.IdSugestao)
            .HasColumnName("id_sugestao");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdCliente)
            .HasColumnName("fk_id_cliente");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdClinica)
            .HasColumnName("fk_id_clinica");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdEspecialista)
            .HasColumnName("fk_id_especialista");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdStatusSugestao)
            .HasColumnName("fk_id_status_sugestao");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdTurno)
            .HasColumnName("fk_id_turno");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdPreferenciaDia)
            .HasColumnName("fk_id_preferencia_dia");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdPreferenciaHorario)
            .HasColumnName("fk_id_preferencia_horario");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdTratamento)
            .HasColumnName("fk_id_tratamento");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkPerfilRecusa)
            .HasColumnName("fk_perfil_recusa");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.FkIdMotivoRecusa)
            .HasColumnName("fk_id_motivo_recusa");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.Cliente)
            .HasColumnName("cliente");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.DescricaoDiaPreferencia)
            .HasColumnName("descricao_dia_preferencia");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.DescricaoHorarioPreferencia)
            .HasColumnName("descricao_horario_preferencia");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.DescricaoTurno)
            .HasColumnName("descricao_turno");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.Clinica)
            .HasColumnName("clinica");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.EnderecoClinica)
            .HasColumnName("endereco_clinica");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.Especialista)
            .HasColumnName("especialista");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.Tratamento)
            .HasColumnName("tratamento");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.StatusSugestao)
            .HasColumnName("status_sugestao");

        modelBuilder.Entity<SugestaoConsulta>()
            .Property(s => s.Custo)
            .HasColumnName("custo");
    }


}
