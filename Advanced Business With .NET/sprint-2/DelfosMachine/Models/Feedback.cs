using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DelfosMachine.Models
{
    [Table("feedback")]
    public class Feedback
    {

        [Key]
        [Column("id_feedback")]
        public int Id { get; set; }

        [Column("fk_id_cliente")]
        [Required]
        public int IdCliente { get; set; }

        [Column("fk_id_especialista")]
        [Required]
        public int IdEspecialista { get; set; }

        [Column("fk_id_clinica")]
        [Required]
        public int IdClinica { get; set; }

        [Column("nota")]
        [Required]
        [Range(0, 5, ErrorMessage = "A nota deve ser entre 0 e 5.")]
        public int Nota { get; set; }

        [Required]
        [Column("comentario")]
        [StringLength(500, ErrorMessage = "O comentário não pode exceder 500 caracteres.")]
        public string? Comentario { get; set; }
    }
}
