using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class TurnoPreferencia
{
    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }

    [Required(ErrorMessage = "O turno é obrigatório")]
    // Manhã, Tarde ou Noite
    public string? Turno { get; set; } 
    
}
