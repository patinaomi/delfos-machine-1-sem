package br.com.projeto

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    // Declaração de variáveis
    private lateinit var voltarImage: ImageView
    private lateinit var esqueciSenhaTextView: TextView
    private lateinit var acessarButton : Button
    private lateinit var loginEditText : EditText
    private lateinit var senhaEditText : EditText
    private lateinit var erroLoginTextView : TextView
    private lateinit var comprarButton: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Inicialização de variáveis
        voltarImage = findViewById(R.id.img_back)
        esqueciSenhaTextView = findViewById(R.id.tv_esqueci_senha)
        loginEditText = findViewById(R.id.et_login)
        senhaEditText = findViewById(R.id.et_senha)
        acessarButton = findViewById(R.id.bt_acessar)
        erroLoginTextView = findViewById(R.id.tv_erro_login)
        comprarButton = findViewById(R.id.bt_comprar)

        voltarImage.setOnClickListener {
            val intent = Intent(this, InicioActivity::class.java)
            startActivity(intent)
        }

        esqueciSenhaTextView.setOnClickListener {
            val intent = Intent(this, RecuperarSenhaActivity::class.java)
            startActivity(intent)
        }

        acessarButton.setOnClickListener {
            validarLogin(loginEditText.text.toString(), senhaEditText.text.toString(), erroLoginTextView)
        }

        comprarButton.setOnClickListener {
            val url = "https://www.odontoprev.com.br"
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = Uri.parse(url)
            startActivity(intent)
        }
    }

    // Como não trabalhamos ainda com persistência no banco, simulamos um login com CPF e senha
    private fun validarLogin(cpf: String, senha: String, erroLoginTextView: TextView) {
        if(cpf.isBlank() || senha.isBlank()) {
            // Caso 1 - CPF ou senha não preenchidos
            erroLoginTextView.text = "CPF e senha são obrigatórios"
            erroLoginTextView.visibility = TextView.VISIBLE

        } else if (cpf == "123456789" && senha == "123456") {
            // Caso 2 - Login efetuado com sucesso
            AlertDialog.Builder(this)
                .setTitle("Login Efetuado")
                .setMessage("Login efetuado com sucesso!")
                .setPositiveButton("OK") { dialog, _ -> dialog.dismiss() }
                .show()

            erroLoginTextView.visibility = TextView.GONE
        } else if (cpf == "123456789" && senha != "123456") {
            // Caso 3 - CPF correto, mas senha incorreta
            erroLoginTextView.text = "Senha inválida"
            erroLoginTextView.visibility = TextView.VISIBLE

        } else {
            // Caso 4 - CPF incorreto
            erroLoginTextView.text = "CPF ou Carteirinha não está cadastrado no banco"
            erroLoginTextView.visibility = TextView.VISIBLE
        }
    }
}
