using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class HorarioPreferencia
{
    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }

    [Required(ErrorMessage = "O horário é obrigatório")]
    // Opções entre 08:00, 09:00 e assim por diante
    public TimeSpan Horario { get; set; }
}
