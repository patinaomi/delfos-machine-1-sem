package br.com.fiap.challenge

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import br.com.fiap.challenge.service.RetrofitInstance
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentHomeBinding
import com.bumptech.glide.Glide
import kotlinx.coroutines.launch

class HomeFragment : Fragment() {
    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentHomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val sharedPref = requireActivity().getSharedPreferences("app_preferences", Context.MODE_PRIVATE)
        val clienteId = sharedPref.getString("clienteId", "") ?: ""

        if (clienteId != null) {
            lifecycleScope.launch {
                try {
                    val response = RetrofitInstance.api.getCliente(clienteId)
                    if (response.isSuccessful) {
                        val user = response.body()
                        val displayName = user?.nome ?: getString(R.string.user)
                        binding.textViewWelcome.text = getString(R.string.welcome_message, displayName)
                    } else {
                        binding.textViewWelcome.text = getString(R.string.welcome_message, getString(R.string.user))
                    }
                } catch (e: Exception) {
                    binding.textViewWelcome.text = getString(R.string.welcome_message, getString(R.string.user))
                }
            }
        } else {
            binding.textViewWelcome.text = getString(R.string.welcome_message, getString(R.string.user))
        }

        binding.buttonEditProfile.setOnClickListener {
            findNavController().navigate(R.id.profileFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
