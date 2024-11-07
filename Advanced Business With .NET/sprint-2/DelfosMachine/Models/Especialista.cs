using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class Especialista
{
    [Key]    
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

    [Required(ErrorMessage = "O Genero é obrigatório")]
    public string? Especialidade { get; set; }

    [Required(ErrorMessage = "A CRM é obrigatória")]
    [DataType(DataType.Password)]
    public string? CRM { get; set; }

    [Required(ErrorMessage = "A senha é obrigatória")]
    [DataType(DataType.Password)]
    public string? Senha { get; set; }
}
