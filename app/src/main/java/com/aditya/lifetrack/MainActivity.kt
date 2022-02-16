package com.aditya.lifetrack

import android.content.Intent
import android.os.Bundle
import android.view.KeyEvent
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.floatingactionbutton.FloatingActionButton
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class MainActivity : AppCompatActivity() {

    private var recyclerView:RecyclerView? = null
    private var gridLayoutManager:GridLayoutManager? = null
    private var recyclerViewAdapter : RecyclerViewAdapter? = null
    private lateinit var btnSubmit: Button
    private lateinit var btnDeleteAll: Button
    private lateinit var etActivity: EditText
    private lateinit var tvDate: TextView
    private lateinit var btnFab : FloatingActionButton

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val db = DatabaseHelper(this)
        val data = db.readData()

        val date = LocalDateTime.now()
        val formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
        val formattedDate = date.format(formatter).toString()

        btnFab = findViewById(R.id.btnFab)

        recyclerView = findViewById(R.id.recyclerView)
        gridLayoutManager = GridLayoutManager(applicationContext, 2, LinearLayoutManager.VERTICAL, false)
        recyclerView?.layoutManager = gridLayoutManager
        recyclerViewAdapter = RecyclerViewAdapter(applicationContext, data)

        recyclerView?.adapter = recyclerViewAdapter

        btnFab.setOnClickListener{
            var dialog = BottomSheetDialog(this)
            val view = layoutInflater.inflate(R.layout.activity_pop_up, null)

            btnSubmit = view.findViewById<Button>(R.id.btnSubmit)
            btnDeleteAll = view.findViewById<Button>(R.id.btnDeleteAll)
            etActivity = view.findViewById<EditText>(R.id.etActivity)
            tvDate = view.findViewById(R.id.tvDate)

            tvDate.text = formattedDate

            btnSubmit.setOnClickListener{
                if (etActivity.text.toString().isNotEmpty()) {
                    val activity = Activity(etActivity.text.toString(), 0)
                    db.insertData(activity)
                    etActivity.text.clear()
                } else {
                    Toast.makeText(this, "Please Fill All Data's", Toast.LENGTH_SHORT).show()
                }
                val intent = Intent(this, MainActivity::class.java)
                startActivity(intent)
            }

//            etActivity.setOnKeyListener { v, keyCode, event ->
//                when {
//                    //Check if it is the Enter-Key,      Check if the Enter Key was pressed down
//                    (((keyCode == KeyEvent.KEYCODE_ENTER) || (keyCode == KeyEvent.FLAG_EDITOR_ACTION))  && (event.action == KeyEvent.ACTION_DOWN)) -> {
//                        val activity = Activity(etActivity.text.toString(), 0)
//                        db.insertData(activity)
//                        etActivity.text.clear()
//                        val intent = Intent(this, MainActivity::class.java)
//                        startActivity(intent)
//                        return@setOnKeyListener true
//                    }
//                    else -> false
//                }
//            }

            btnDeleteAll.setOnClickListener {
                db.deleteData()
                val intent = Intent(this, MainActivity::class.java)
                startActivity(intent)
            }
            dialog.setContentView(view)
            dialog.show()
        }

    }
}