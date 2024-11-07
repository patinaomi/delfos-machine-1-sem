
namespace DelfosMachine.Models;

public class AtividadeMedicos
{
    public int Id { get; set; }
    public string? Descricao { get; set; }

    // 'pendente' ou 'concluido'
    public string? Status { get; set; } 
    public int Pontos { get; set; }
}
