using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class EnderecoPreferencia
{
    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }

    [Required(ErrorMessage = "O CEP é obrigatório")]
    [StringLength(8, ErrorMessage = "O CEP deve ter no máximo 8 caracteres, sem acentos")]
    public string? CEP { get; set; }

    [Required(ErrorMessage = "O Estado é obrigatório")]
    public string? Estado { get; set; }

    [Required(ErrorMessage = "A Cidade é obrigatória")]
    public string? Cidade { get; set; }

    [Required(ErrorMessage = "O Bairro é obrigatório")]
    public string? Bairro { get; set; }

    [Required(ErrorMessage = "A Rua é obrigatória")]
    public string? Rua { get; set; }

    public string? Complemento { get; set; }

}
