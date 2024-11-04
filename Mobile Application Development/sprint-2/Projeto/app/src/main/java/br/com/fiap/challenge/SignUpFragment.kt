package br.com.fiap.challenge

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import android.widget.Toast.LENGTH_LONG
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import br.com.fiap.mad.crafters.databinding.FragmentSignupBinding
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.UserProfileChangeRequest
import com.google.firebase.auth.auth
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import java.lang.Exception

class SignUpFragment : Fragment() {
    private lateinit var auth: FirebaseAuth

    private var _binding: FragmentSignupBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = Firebase.auth
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentSignupBinding.inflate(layoutInflater, container, false)

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.buttonSignUp.setOnClickListener {
            val email = binding.editTextEmailAddress.text.toString()
            val password = binding.editTextPassword.text.toString()

            lifecycleScope.launch {
                try {
                    val result = auth.createUserWithEmailAndPassword(email, password).await()

                    val currentUser = result.user
                    if (currentUser != null) {
                        val request = UserProfileChangeRequest.Builder()
                            .setDisplayName(binding.editTextName.text.toString())
                            .build()
                        currentUser.updateProfile(request).await()

                        // redirect
                        Toast.makeText(requireContext(), "Usuario criado", Toast.LENGTH_LONG)
                            .show()
                    } else {
                        Toast.makeText(
                            requireContext(),
                            "Erro ao criar o usuario",
                            Toast.LENGTH_LONG
                        ).show()
                    }
                } catch (ex: Exception) {
                    Toast.makeText(requireContext(), ex.message, Toast.LENGTH_LONG)
                        .show()
                }
            }
        }
    }
    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}