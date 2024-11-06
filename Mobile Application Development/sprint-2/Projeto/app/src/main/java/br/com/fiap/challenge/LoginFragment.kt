package br.com.fiap.challenge

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import br.com.fiap.challenge.models.LoginRequest
import br.com.fiap.challenge.service.RetrofitInstance
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentLoginBinding
import com.google.firebase.auth.FirebaseAuth
import kotlinx.coroutines.launch

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
            findNavController().navigate(R.id.mainFragment)
        }

        binding.tvEsqueciSenha.setOnClickListener {
            findNavController().navigate(R.id.forgotPasswordFragment)
        }

        binding.btAcessar.setOnClickListener {
            val email = binding.etLogin.text.toString().trim()
            val senha = binding.etSenha.text.toString().trim()

            lifecycleScope.launch {
                try {
                    val response = RetrofitInstance.api.login(LoginRequest(email, senha))
                    if (response.isSuccessful) {
                        // Se o login dar certo, vai pra proxima tela
                        val loginResponse = response.body()
                        val clienteId = loginResponse?.id

                        val sharedPref = requireActivity().getSharedPreferences("app_preferences", Context.MODE_PRIVATE)
                        with(sharedPref.edit()) {
                            putString("clienteId", clienteId)
                            apply()
                        }

                        findNavController().navigate(R.id.homeFragment)
                    } else {

                        // Exibe mensagem de erro
                        val errorBody = response.errorBody()?.string()
                        binding.tvErroLogin.text = getString(R.string.erro_no_login)
                        binding.tvErroLogin.visibility = View.VISIBLE
                    }
                } catch (e: Exception) {
                    binding.tvErroLogin.text = getString(R.string.erro_na_comunicacao)
                    binding.tvErroLogin.visibility = View.VISIBLE
                }
            }
        }


        binding.btComprar.setOnClickListener {
            val url = "https://www.odontoprev.com.br"
            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
            startActivity(intent)
        }
    }

    private fun realizarLogin(email: String, senha: String, erroLoginTextView: TextView) {
        if (email.isBlank() || senha.isBlank()) {
            erroLoginTextView.text = getString(R.string.e_mail_e_senha_obrigatorios)
            erroLoginTextView.visibility = View.VISIBLE
        } else {
            lifecycleScope.launch {
                try {
                    val response = RetrofitInstance.api.login(LoginRequest(email, senha))
                    if (response.isSuccessful) {
                        val loginResponse = response.body()
                        if (loginResponse != null && loginResponse.message == "Login bem-sucedido") {
                            // Login deu certo, ai vai pra home
                            findNavController().navigate(R.id.homeFragment)
                        } else {
                            erroLoginTextView.text = getString(R.string.credenciais_invalidas)
                            erroLoginTextView.visibility = View.VISIBLE
                        }
                    } else {
                        erroLoginTextView.text = getString(R.string.erro_no_servidor)
                        erroLoginTextView.visibility = View.VISIBLE
                    }
                } catch (e: Exception) {
                    erroLoginTextView.text = getString(R.string.falha_no_login)
                    erroLoginTextView.visibility = View.VISIBLE
                }
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}