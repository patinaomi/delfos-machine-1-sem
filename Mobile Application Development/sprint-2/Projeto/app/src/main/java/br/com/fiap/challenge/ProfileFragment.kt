package br.com.fiap.challenge

import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.lifecycle.lifecycleScope
import br.com.fiap.mad.crafters.R
import br.com.fiap.mad.crafters.databinding.FragmentProfileBinding
import com.bumptech.glide.Glide
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import com.google.firebase.auth.userProfileChangeRequest
import com.google.firebase.storage.FirebaseStorage
import com.google.firebase.storage.storage
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import java.io.ByteArrayOutputStream
import java.util.Calendar

class ProfileFragment : Fragment() {
    private lateinit var auth: FirebaseAuth
    private lateinit var storage: FirebaseStorage
    private var _binding: FragmentProfileBinding? = null
    private val binding get() = _binding!!
    private var updateProfilePicture = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        auth = Firebase.auth
        storage = Firebase.storage
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentProfileBinding.inflate(inflater, container, false)

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val user = auth.currentUser!!

        binding.editTextName.setText(user.displayName)

        if (user.photoUrl != null) {
            Glide
                .with(requireContext())
                .load(user.photoUrl)
                .into(binding.imageViewAvatar)
        } else {
            binding.imageViewAvatar.setImageResource(R.drawable.profile)
        }

        binding.buttonSave.setOnClickListener {
            saveProfile()
        }

        setUpImagePicker()
    }

    private fun setUpImagePicker() {
        val picker = registerForActivityResult(ActivityResultContracts.GetContent()) {
            if (it != null) {
                updateProfilePicture = true
                binding.imageViewAvatar.setImageURI(it)
            }
        }

        binding.imageViewAvatar.setOnClickListener {
            picker.launch("image/*")
        }
    }

    private fun saveProfile() {
        val name = binding.editTextName.text.toString()

        binding.buttonSave.isEnabled = false

        lifecycleScope.launch {
            val photoUrl = if (updateProfilePicture) uploadPicture() else null
            val userChange = userProfileChangeRequest {
                displayName = name
                if (photoUrl != null) photoUri = photoUrl
            }
            auth.currentUser!!.updateProfile(userChange).await()
            binding.buttonSave.isEnabled = true
            Toast.makeText(
                requireContext(),
                "Perfil atualizado!",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    private suspend fun uploadPicture(): Uri {
        val imageRef = storage.reference.child("profile_pictures/${auth.currentUser!!.uid}/${Calendar.getInstance().timeInMillis}.jpg")

        val bitmap = (binding.imageViewAvatar.drawable as BitmapDrawable).bitmap
        val baos = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos)
        val data = baos.toByteArray()

        imageRef.putBytes(data).await()

        val downloadUrl = imageRef.downloadUrl.await()

        return downloadUrl
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}