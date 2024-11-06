package br.com.fiap.challenge

import android.content.Context
import android.os.Bundle
import android.util.Patterns
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentRegisterBinding
import java.text.SimpleDateFormat
import java.util.*

class RegisterFragment : Fragment() {

    private var _binding: FragmentRegisterBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentRegisterBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Configura o botão Continuar
        binding.btnContinuar.setOnClickListener {
            val nome = binding.etNome.text.toString()
            val sobrenome = binding.etSobrenome.text.toString()
            val email = binding.etEmail.text.toString()
            val telefone = binding.etTelefone.text.toString()
            val dataNascimento = binding.etDataNascimento.text.toString()

            // Valida os dados
            if (!isNomeValido(nome)) {
                Toast.makeText(requireContext(), "Nome deve ter pelo menos 3 caracteres", Toast.LENGTH_SHORT).show()
            } else if (!isSobrenomeValido(sobrenome)) {
                Toast.makeText(requireContext(), "Sobrenome deve ter pelo menos 3 caracteres", Toast.LENGTH_SHORT).show()
            } else if (!isEmailValido(email)) {
                Toast.makeText(requireContext(), "E-mail inválido", Toast.LENGTH_SHORT).show()
            } else if (!isTelefoneValido(telefone)) {
                Toast.makeText(requireContext(), "Telefone inválido", Toast.LENGTH_SHORT).show()
            } else if (!isDataNascimentoValida(dataNascimento)) {
                Toast.makeText(requireContext(), "Data de nascimento inválida. Formato esperado: YYYY-MM-DD", Toast.LENGTH_SHORT).show()
            } else {
                // Armazena os dados válidos
                val sharedPreferences = requireContext().getSharedPreferences("CadastroPrefs", Context.MODE_PRIVATE)
                sharedPreferences.edit().apply {
                    putString("nome", nome)
                    putString("sobrenome", sobrenome)
                    putString("email", email)
                    putString("telefone", telefone)
                    putString("dataNascimento", dataNascimento)
                    apply()
                }

                // Navega para o próximo fragmento
                findNavController().navigate(R.id.registerPasswordFragment)
            }
        }
    }


    // Funções de validação

    private fun isNomeValido(nome: String): Boolean {
        return nome.length >= 3
    }

    private fun isSobrenomeValido(sobrenome: String): Boolean {
        return sobrenome.length >= 3
    }

    private fun isEmailValido(email: String): Boolean {
        return Patterns.EMAIL_ADDRESS.matcher(email).matches() && email.contains("@") && email.contains(".")
    }

    private fun formatarTelefone(telefone: String): String {
        return telefone.filter { it.isDigit() }
    }

    private fun isTelefoneValido(telefone: String): Boolean {
        var telLimpo = formatarTelefone(telefone)
        return telLimpo.all { it.isDigit() }
    }

    private fun isDataNascimentoValida(data: String): Boolean {
        val formato = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
        formato.isLenient = false
        return try {
            formato.parse(data)
            true
        } catch (e: Exception) {
            false
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
