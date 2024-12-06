using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class Cliente
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
    public string? Genero { get; set; }
    
    [Required(ErrorMessage = "A data de nascimento é obrigatória")]
    public DateTime DataNasc { get; set; }

    [Required(ErrorMessage = "A senha é obrigatória")]
    [DataType(DataType.Password)]
    public string? Senha { get; set; }
}
