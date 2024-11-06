package br.com.fiap.challenge

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import br.com.fiap.challenge.models.ValidateEmailRequest
import br.com.fiap.challenge.service.RetrofitInstance
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentFirstAccessBinding
import kotlinx.coroutines.launch

class FirstAccessFragment : Fragment() {

    private var _binding: FragmentFirstAccessBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentFirstAccessBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Botão de Voltar
        binding.imgBack.setOnClickListener {
            findNavController().popBackStack()
        }

        // Botão do Cadastrar
        binding.btnCadastrar.setOnClickListener {
            val email = binding.etEmail.text.toString()
            if(email.isNotBlank()) {
                verifyEmail(email)
            } else {
                Toast.makeText(requireContext(), "Preencha o campo de e-mail", Toast.LENGTH_SHORT).show()
            }
        }

        // Botão do Simule seu plano
        binding.btnSimulePlano.setOnClickListener {
            val url = "https://www.odontoprev.com.br/planos"
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
            startActivity(intent)
        }
    }

    private fun verifyEmail(email: String) {
        lifecycleScope.launch {
            try {
                val response = RetrofitInstance.api.validateEmail(ValidateEmailRequest(email))

                if(response.isSuccessful && response.body() != null) {
                    val emailExists = response.body()!!.emailExists
                    println(emailExists)

                    if(emailExists) {
                        Toast.makeText(requireContext(), "E-mail já cadastrado", Toast.LENGTH_SHORT).show()
                        findNavController().navigate(R.id.loginFragment)
                    } else {
                        findNavController().navigate(R.id.registerFragment)
                    }
                } else {
                    Toast.makeText(requireContext(), "Erro ao verificar e-mail", Toast.LENGTH_SHORT).show()
                }
            } catch (e: Exception) {
                Toast.makeText(requireContext(), "Erro ao verificar e-mail", Toast.LENGTH_SHORT).show()
            }
        }

    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
