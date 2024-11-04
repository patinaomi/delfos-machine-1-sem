package br.com.fiap.challenge

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import br.com.fiap.challenge.models.ValidateUserRequest
import br.com.fiap.challenge.service.RetrofitInstance
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentForgotPasswordBinding
import kotlinx.coroutines.launch

class ForgotPasswordFragment : Fragment() {

    private var _binding: FragmentForgotPasswordBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentForgotPasswordBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.btnValidar.setOnClickListener {
            val email = binding.etEmail.text.toString().trim()
            val dataNasc = binding.etDataNasc.text.toString().trim()

            if (email.isNotEmpty() && dataNasc.isNotEmpty()) {
                lifecycleScope.launch {
                    try {
                        // Cria a requisição com e-mail e data de nascimento
                        val request = ValidateUserRequest(email, dataNasc)
                        val response = RetrofitInstance.api.validateUser(request)

                        if (response.isSuccessful) {
                            // Validação bem-sucedida, navega para a tela de redefinição de senha
                            findNavController().navigate(R.id.resetPasswordFragment)
                        } else {
                            // Mostra uma mensagem de erro se os dados estiverem incorretos
                            Toast.makeText(requireContext(), "Dados incorretos", Toast.LENGTH_LONG).show()
                        }
                    } catch (e: Exception) {
                        Toast.makeText(requireContext(), "Erro: ${e.message}", Toast.LENGTH_LONG).show()
                    }
                }
            } else {
                Toast.makeText(requireContext(), "Por favor, insira todos os dados", Toast.LENGTH_LONG).show()
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
