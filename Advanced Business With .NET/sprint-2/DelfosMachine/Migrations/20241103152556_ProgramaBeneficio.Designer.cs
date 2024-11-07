﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Oracle.EntityFrameworkCore.Metadata;

#nullable disable

namespace DelfosMachine.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20241103152556_ProgramaBeneficio")]
    partial class ProgramaBeneficio
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            OracleModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("DelfosMachine.Models.Cliente", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("DataNasc")
                        .HasColumnType("TIMESTAMP(7)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Genero")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)");

                    b.Property<string>("Senha")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Telefone")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("Clientes");
                });

            modelBuilder.Entity("DelfosMachine.Models.DiaSemanaPreferencia", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("DiaSemana")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.HasKey("Id");

                    b.ToTable("PreferenciaDia");
                });

            modelBuilder.Entity("DelfosMachine.Models.EnderecoPreferencia", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Bairro")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("CEP")
                        .IsRequired()
                        .HasMaxLength(8)
                        .HasColumnType("NVARCHAR2(8)");

                    b.Property<string>("Cidade")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Complemento")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Estado")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.Property<string>("Rua")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("EnderecoPreferencia");
                });

            modelBuilder.Entity("DelfosMachine.Models.Especialista", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("CRM")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Especialidade")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)");

                    b.Property<string>("Senha")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Telefone")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("Especialista");
                });

            modelBuilder.Entity("DelfosMachine.Models.Feedback", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("id_feedback");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Comentario")
                        .IsRequired()
                        .HasMaxLength(500)
                        .HasColumnType("NVARCHAR2(500)")
                        .HasColumnName("comentario");

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_cliente");

                    b.Property<int>("IdClinica")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_clinica");

                    b.Property<int>("IdEspecialista")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_especialista");

                    b.Property<int>("Nota")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("nota");

                    b.HasKey("Id");

                    b.ToTable("feedback");
                });

            modelBuilder.Entity("DelfosMachine.Models.HorarioPreferencia", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<TimeSpan>("Horario")
                        .HasColumnType("INTERVAL DAY(8) TO SECOND(7)");

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.HasKey("Id");

                    b.ToTable("PreferenciaHorario");
                });

            modelBuilder.Entity("DelfosMachine.Models.Medico", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Especialidade")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)");

                    b.Property<string>("Telefone")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("Medicos");
                });

            modelBuilder.Entity("DelfosMachine.Models.PreferenciaCliente", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("IdDiaSemana")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("IdEndereco")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("IdHorario")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("IdTurno")
                        .HasColumnType("NUMBER(10)");

                    b.HasKey("Id");

                    b.HasIndex("IdDiaSemana");

                    b.HasIndex("IdEndereco");

                    b.HasIndex("IdHorario");

                    b.HasIndex("IdTurno");

                    b.ToTable("PreferenciasClientes");
                });

            modelBuilder.Entity("DelfosMachine.Models.RotinaCuidadoCliente", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("CuidadosEspecificos")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<int>("FrequenciaEnxaguante")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("FrequenciaEscovacao")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("FrequenciaFioDental")
                        .HasColumnType("NUMBER(10)");

                    b.Property<int>("FrequenciaVisitasDentista")
                        .HasColumnType("NUMBER(10)");

                    b.Property<string>("HabitosAlimentares")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("HistoricoMedico")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.Property<string>("SintomasAtuais")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("RotinaCuidado");
                });

            modelBuilder.Entity("DelfosMachine.Models.ServicosPendentes", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Cliente")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Data")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Descricao")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Hora")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Localizacao")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.Property<string>("Status")
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("ServicosPendentes");
                });

            modelBuilder.Entity("DelfosMachine.Models.SugestaoConsulta", b =>
                {
                    b.Property<int>("IdSugestao")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("id_sugestao");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("IdSugestao"));

                    b.Property<string>("Cliente")
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)")
                        .HasColumnName("cliente");

                    b.Property<string>("Clinica")
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)")
                        .HasColumnName("clinica");

                    b.Property<decimal>("Custo")
                        .HasColumnType("DECIMAL(18, 2)")
                        .HasColumnName("custo");

                    b.Property<string>("DescricaoDiaPreferencia")
                        .HasMaxLength(15)
                        .HasColumnType("NVARCHAR2(15)")
                        .HasColumnName("descricao_dia_preferencia");

                    b.Property<string>("DescricaoHorarioPreferencia")
                        .HasMaxLength(15)
                        .HasColumnType("NVARCHAR2(15)")
                        .HasColumnName("descricao_horario_preferencia");

                    b.Property<string>("DescricaoTurno")
                        .HasMaxLength(10)
                        .HasColumnType("NVARCHAR2(10)")
                        .HasColumnName("descricao_turno");

                    b.Property<string>("EnderecoClinica")
                        .HasMaxLength(255)
                        .HasColumnType("NVARCHAR2(255)")
                        .HasColumnName("endereco_clinica");

                    b.Property<string>("Especialista")
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)")
                        .HasColumnName("especialista");

                    b.Property<int>("FkIdCliente")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_cliente");

                    b.Property<int>("FkIdClinica")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_clinica");

                    b.Property<int>("FkIdEspecialista")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_especialista");

                    b.Property<int>("FkIdMotivoRecusa")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_motivo_recusa");

                    b.Property<int>("FkIdPreferenciaDia")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_preferencia_dia");

                    b.Property<int>("FkIdPreferenciaHorario")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_preferencia_horario");

                    b.Property<int>("FkIdStatusSugestao")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_status_sugestao");

                    b.Property<int>("FkIdTratamento")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_tratamento");

                    b.Property<int>("FkIdTurno")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_id_turno");

                    b.Property<int>("FkPerfilRecusa")
                        .HasColumnType("NUMBER(10)")
                        .HasColumnName("fk_perfil_recusa");

                    b.Property<string>("StatusSugestao")
                        .HasMaxLength(15)
                        .HasColumnType("NVARCHAR2(15)")
                        .HasColumnName("status_sugestao");

                    b.Property<string>("Tratamento")
                        .HasMaxLength(100)
                        .HasColumnType("NVARCHAR2(100)")
                        .HasColumnName("tratamento");

                    b.HasKey("IdSugestao");

                    b.ToTable("sugestaoConsulta", (string)null);
                });

            modelBuilder.Entity("DelfosMachine.Models.TurnoPreferencia", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("NUMBER(10)");

                    OraclePropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("IdCliente")
                        .HasColumnType("NUMBER(10)");

                    b.Property<string>("Turno")
                        .IsRequired()
                        .HasColumnType("NVARCHAR2(2000)");

                    b.HasKey("Id");

                    b.ToTable("Turno");
                });

            modelBuilder.Entity("DelfosMachine.Models.PreferenciaCliente", b =>
                {
                    b.HasOne("DelfosMachine.Models.DiaSemanaPreferencia", "DiaSemanaPreferencia")
                        .WithMany()
                        .HasForeignKey("IdDiaSemana")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("DelfosMachine.Models.EnderecoPreferencia", "EnderecoPreferencia")
                        .WithMany()
                        .HasForeignKey("IdEndereco")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("DelfosMachine.Models.HorarioPreferencia", "HorarioPreferencia")
                        .WithMany()
                        .HasForeignKey("IdHorario")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("DelfosMachine.Models.TurnoPreferencia", "TurnoPreferencia")
                        .WithMany()
                        .HasForeignKey("IdTurno")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("DiaSemanaPreferencia");

                    b.Navigation("EnderecoPreferencia");

                    b.Navigation("HorarioPreferencia");

                    b.Navigation("TurnoPreferencia");
                });
#pragma warning restore 612, 618
        }
    }
}
