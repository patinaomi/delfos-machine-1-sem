using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DelfosMachine.Models
{
    [Table("sugestaoConsulta")]
    public class SugestaoConsulta
    {
        [Key]
        [Column("id_sugestao")] 
        public int IdSugestao { get; set; }

        [Column("fk_id_cliente")]
        public int FkIdCliente { get; set; }

        [Column("fk_id_clinica")]
        public int FkIdClinica { get; set; }

        [Column("fk_id_especialista")]
        public int FkIdEspecialista { get; set; }

        [Column("fk_id_status_sugestao")]
        public int FkIdStatusSugestao { get; set; }

        [Column("fk_id_turno")]
        public int FkIdTurno { get; set; }

        [Column("fk_id_preferencia_dia")]
        public int FkIdPreferenciaDia { get; set; }

        [Column("fk_id_preferencia_horario")]
        public int FkIdPreferenciaHorario { get; set; }

        [Column("fk_id_tratamento")]
        public int FkIdTratamento { get; set; }

        [Column("fk_perfil_recusa")]
        public int FkPerfilRecusa { get; set; }

        [Column("fk_id_motivo_recusa")]
        public int FkIdMotivoRecusa { get; set; }

        [Column("cliente")]
        [MaxLength(100)]
        public string? Cliente { get; set; }

        [Column("descricao_dia_preferencia")]
        [MaxLength(15)]
        public string? DescricaoDiaPreferencia { get; set; }

        [Column("descricao_horario_preferencia")]
        [MaxLength(15)]
        public string? DescricaoHorarioPreferencia { get; set; }

        [Column("descricao_turno")]
        [MaxLength(10)]
        public string? DescricaoTurno { get; set; }

        [Column("clinica")]
        [MaxLength(100)]
        public string? Clinica { get; set; }

        [Column("endereco_clinica")]
        [MaxLength(255)]
        public string? EnderecoClinica { get; set; }

        [Column("especialista")]
        [MaxLength(100)]
        public string? Especialista { get; set; }

        [Column("tratamento")]
        [MaxLength(100)]
        public string? Tratamento { get; set; }

        [Column("status_sugestao")]
        [MaxLength(15)]
        public string? StatusSugestao { get; set; }

        [Column("custo")]
        public decimal Custo { get; set; }
    }
}
