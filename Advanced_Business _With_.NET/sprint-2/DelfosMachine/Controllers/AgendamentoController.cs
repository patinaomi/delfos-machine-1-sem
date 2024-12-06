
using Microsoft.AspNetCore.Mvc;

public class AgendamentoController : Controller
{

    private static List<Agendamento> agendamentos = new List<Agendamento>
    {
        new Agendamento { Id = 1, Dia = "Segunda", Hora = "18:00", Medico = "Dr. João", Cliente = "Maria", TipoConsulta = "presencial", Descricao = "Limpeza", Status = "concluida" },
        new Agendamento { Id = 2, Dia = "Quinta", Hora = "11:00", Medico = "Dr. Ana", Cliente = "Pedro", TipoConsulta = "remota", Descricao = "Consulta de rotina", Status = "pendente" },
        
    };

    public IActionResult Consultar()
    {
        return View(agendamentos);
    }

    [HttpPost]
    public IActionResult AlterarConsulta(int id, Agendamento agendamentoAlterado)
    {
        var agendamento = agendamentos.FirstOrDefault(a => a.Id == id);
        if (agendamento != null)
        {
            agendamento.Medico = agendamentoAlterado.Medico;
            agendamento.Cliente = agendamentoAlterado.Cliente;
            agendamento.Dia = agendamentoAlterado.Dia;
            agendamento.Hora = agendamentoAlterado.Hora;
            agendamento.Descricao = agendamentoAlterado.Descricao;
        }
        return RedirectToAction("Consultar");
    }

    [HttpPost]
    public IActionResult CancelarConsulta(int id, string motivo)
    {
        var agendamento = agendamentos.FirstOrDefault(a => a.Id == id);
        if (agendamento != null)
        {
            agendamento.Status = "cancelada";
            agendamento.Descricao += " - Cancelado: " + motivo;
        }
        return RedirectToAction("Consultar");
    }
}
