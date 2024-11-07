
namespace DelfosMachine.Models;

public class ProgramaIncentivoCliente
{
    public int IdCliente { get; set; }
    public string? Nome { get; set; }
    public required List<Atividade> Atividades { get; set; }
    public int TotalPontos { get; set; }
}

