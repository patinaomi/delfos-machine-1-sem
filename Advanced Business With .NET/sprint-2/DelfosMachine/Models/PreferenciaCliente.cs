using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace DelfosMachine.Models;

// Está Model vai se relacionar com as demais pois um único formulário precisa enviar os dados para suas respectivas tabelas.

public class PreferenciaCliente
{
    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }

    [ForeignKey("EnderecoPreferencia")]
    public int IdEndereco { get; set; }
    public required EnderecoPreferencia EnderecoPreferencia { get; set; }

    [ForeignKey("TurnoPreferencia")]
    public int IdTurno { get; set; }
    public required TurnoPreferencia TurnoPreferencia { get; set; }

    [ForeignKey("HorarioPreferencia")]
    public int IdHorario { get; set; }
    public required HorarioPreferencia HorarioPreferencia { get; set; }

    [ForeignKey("DiaSemanaPreferencia")]
    public int IdDiaSemana { get; set; }
    public required DiaSemanaPreferencia DiaSemanaPreferencia { get; set; }
    
}
