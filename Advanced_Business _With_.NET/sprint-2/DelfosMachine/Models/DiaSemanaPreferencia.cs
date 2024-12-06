using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class DiaSemanaPreferencia
{
    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }

    [Required(ErrorMessage = "O dia é obrigatório")]
    // Segunda, Terça, Quarta, Quinta, Sexta ou Sábado
    public string? DiaSemana { get; set; }
}
