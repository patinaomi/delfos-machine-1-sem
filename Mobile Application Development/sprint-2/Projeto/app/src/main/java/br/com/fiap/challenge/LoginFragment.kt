package br.com.fiap.challenge

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentLoginBinding
import com.google.firebase.auth.FirebaseAuth

class LoginFragment : Fragment() {
    private lateinit var auth: FirebaseAuth
    private var _binding: FragmentLoginBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = FirebaseAuth.getInstance()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentLoginBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.imgBack.setOnClickListener {
            findNavController().navigate(R.id.homeFragment)
        }

        binding.tvEsqueciSenha.setOnClickListener {
            findNavController().navigate(R.id.forgotPasswordFragment)
        }

        binding.btAcessar.setOnClickListener {
            val cpf = binding.etLogin.text.toString()
            val senha = binding.etSenha.text.toString()
            validarLogin(cpf, senha, binding.tvErroLogin)
        }

        binding.btComprar.setOnClickListener {
            val url = "https://www.odontoprev.com.br"
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
            startActivity(intent)
        }
    }

    private fun validarLogin(cpf: String, senha: String, erroLoginTextView: TextView) {
        if (cpf.isBlank() || senha.isBlank()) {
            // Caso 1 - CPF ou senha não preenchidos
            erroLoginTextView.text = "CPF e senha são obrigatórios"
            erroLoginTextView.visibility = View.VISIBLE
        } else if (cpf == "123456789" && senha == "123456") {
            // Caso 2 - Login efetuado com sucesso
            AlertDialog.Builder(requireContext())
                .setTitle("Login Efetuado")
                .setMessage("Login efetuado com sucesso!")
                .setPositiveButton("OK") { dialog, _ -> dialog.dismiss() }
                .show()
            erroLoginTextView.visibility = View.GONE
        } else if (cpf == "123456789" && senha != "123456") {
            // Caso 3 - CPF correto, mas senha incorreta
            erroLoginTextView.text = "Senha inválida"
            erroLoginTextView.visibility = View.VISIBLE
        } else {
            // Caso 4 - CPF incorreto
            erroLoginTextView.text = "CPF ou Carteirinha não está cadastrado no banco"
            erroLoginTextView.visibility = View.VISIBLE
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
