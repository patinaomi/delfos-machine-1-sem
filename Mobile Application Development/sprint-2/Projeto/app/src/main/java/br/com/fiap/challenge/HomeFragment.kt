package br.com.fiap.challenge

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.findNavController
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentHomeBinding
import com.bumptech.glide.Glide

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
        // Configurando a mensagem de boas-vindas com um nome padrão
        val displayName = getString(R.string.user) // Nome padrão
        binding.textViewWelcome.text = getString(R.string.welcome_message, displayName)

        // Configurando uma imagem padrão no avatar
        binding.imageViewAvatar.setImageResource(R.drawable.profile)

        // Configurando o botão para navegar até o perfil
        binding.buttonEditProfile.setOnClickListener {
            findNavController().navigate(R.id.profileFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
