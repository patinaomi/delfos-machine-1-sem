package com.example.myapplication

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.lifecycleScope
import com.example.myapplication.databinding.FragmentLoginBinding
import com.example.myapplication.databinding.FragmentSignupBinding
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.UserProfileChangeRequest
import com.google.firebase.auth.auth
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await


class SignUpFragment : Fragment() {
    private lateinit var auth: FirebaseAuth

    private var _binding : FragmentSignupBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = Firebase.auth
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        @SuppressLint("ShowToast")
        fun onViewCreated(view: View, savedInstanceState: Bundle?) {
            binding.buttonSignUp.setOnClickListener {
                val email = binding.editTextEmailAddress.text.toString()
                val password = binding.editTextPassword.text.toString()

                lifecycleScope.launch {
                    try {
                    val result = auth.createUserWithEmailAndPassword(email, password).await()
                    val currentUser = result.user

                    if(currentUser != null) {
                        val request = UserProfileChangeRequest.Builder()
                            .setDisplayName(binding.editTextName.toString())
                            .build()
                        currentUser.updateProfile(request).await()
                        Toast.makeText(requireContext(), "Usuário criado", Toast.LENGTH_LONG)
                    } else {
                        Toast.makeText(requireContext(), "Erro ao criar o usuário", Toast.LENGTH_LONG)
                    }
                } catch( ex: Exception) {
                    Toast.makeText(requireContext(), ex.message, Toast.LENGTH_LONG)
                    }
            }

            }
        }
        _binding = FragmentSignupBinding.inflate(layoutInflater, container, false)
        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}