
using System.ComponentModel.DataAnnotations;

namespace DelfosMachine.Models
{
    public class Medico
    {
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string? Nome { get; set; }

        [Required]
        [EmailAddress]
        public string? Email { get; set; }

        [Required]
        [Phone]
        public string? Telefone { get; set; }

        public string? Especialidade { get; set; }

    }
}
