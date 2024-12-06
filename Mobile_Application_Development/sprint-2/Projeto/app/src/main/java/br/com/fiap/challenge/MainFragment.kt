package br.com.fiap.challenge

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.findNavController
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentMainBinding

class MainFragment : Fragment() {

    private var _binding: FragmentMainBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentMainBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // as imagens do carrossel
        val images = listOf(
            R.drawable.image1,
            R.drawable.image2,
            R.drawable.image3,
            R.drawable.image4
        )

        val adapter = CarouselAdapter(images)
        binding.viewPager.adapter = adapter
        binding.indicator.setViewPager(binding.viewPager)

        // Botão Entrar
        binding.btnEntrar.setOnClickListener {
            findNavController().navigate(R.id.loginFragment)
        }

        // Botão Primeiro Acesso
        binding.btnPrimeiroAcesso.setOnClickListener {
            findNavController().navigate(R.id.firstAccessFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
