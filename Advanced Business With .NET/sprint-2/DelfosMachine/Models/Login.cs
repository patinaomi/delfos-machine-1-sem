using System.ComponentModel.DataAnnotations;

namespace DelfosMachine.Models
{
    public class Login
    {
        [Required]
        [EmailAddress]
        public string? Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string? Senha { get; set; }
    }
}
