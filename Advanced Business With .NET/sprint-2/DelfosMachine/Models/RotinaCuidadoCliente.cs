
using System.ComponentModel.DataAnnotations;
namespace DelfosMachine.Models;

public class RotinaCuidadoCliente
{

    [Key]    
    public int Id { get; set; }

    public int IdCliente { get; set; }
    
    [Required(ErrorMessage = "O histórico médico é obrigatório.")]
    public string? HistoricoMedico { get; set; }

    [Required(ErrorMessage = "A frequência de escovação é obrigatória.")]
    [Range(0, 10, ErrorMessage = "A frequência de escovação deve estar entre 0 e 10 vezes por dia.")]
    public int FrequenciaEscovacao { get; set; }

    [Required(ErrorMessage = "A frequência do uso de fio dental é obrigatória.")]
    [Range(0, 10, ErrorMessage = "A frequência do uso de fio dental deve estar entre 0 e 10 vezes por dia.")]
    public int FrequenciaFioDental { get; set; }

    [Required(ErrorMessage = "A frequência do uso de enxaguante bucal é obrigatória.")]
    [Range(0, 10, ErrorMessage = "A frequência do uso de enxaguante bucal deve estar entre 0 e 10 vezes por dia.")]
    public int FrequenciaEnxaguante { get; set; }

    [Required(ErrorMessage = "A descrição dos sintomas atuais é obrigatória.")]
    public string? SintomasAtuais { get; set; }

    [Required(ErrorMessage = "Os hábitos alimentares são obrigatórios.")]
    public string? HabitosAlimentares { get; set; }

    [Required(ErrorMessage = "A frequência de visitas ao dentista é obrigatória.")]
    [Range(0, 12, ErrorMessage = "A frequência de visitas ao dentista deve estar entre 0 e 12 vezes por ano.")]
    public int FrequenciaVisitasDentista { get; set; }

    [Required(ErrorMessage = "A descrição dos cuidados específicos é obrigatória.")]
    public string? CuidadosEspecificos { get; set; }
}
