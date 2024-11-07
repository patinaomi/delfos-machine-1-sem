using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class DadosCadastrais
{
    public required Cliente Cliente { get; set; } = new Cliente();
    public required EnderecoPreferencia Endereco { get; set; } = new EnderecoPreferencia();
    public required DiaSemanaPreferencia DiaSemana { get; set; } = new DiaSemanaPreferencia();
    public required TurnoPreferencia Turnos { get; set; }  = new TurnoPreferencia();
    public required HorarioPreferencia Horarios { get; set; } = new HorarioPreferencia();
    
}
