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
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth

class HomeFragment : Fragment() {
    private lateinit var auth: FirebaseAuth
    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = Firebase.auth
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentHomeBinding.inflate(inflater, container, false)

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val user = auth.currentUser!!

        val displayName = if (user.displayName != "") user.displayName else getString(
            R.string.user
        )
        binding.textViewWelcome.text = getString(R.string.welcome_message, displayName)

        if (user.photoUrl != null) {
            Glide
                .with(requireContext())
                .load(user.photoUrl)
                .into(binding.imageViewAvatar)
        } else {
            binding.imageViewAvatar.setImageResource(R.drawable.profile)
        }

        binding.buttonEditProfile.setOnClickListener {
            findNavController().navigate(R.id.profileFragment)
        }
    }

    override fun onStart() {
        super.onStart()

        if (auth.currentUser == null) {
            findNavController().navigate(R.id.loginFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}