package com.aditya.lifetrack

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.floatingactionbutton.FloatingActionButton

class MainActivity : AppCompatActivity() {

    private var recyclerView:RecyclerView? = null
    private var gridLayoutManager:GridLayoutManager? = null
    private var recyclerViewAdapter : RecyclerViewAdapter? = null
    private lateinit var btnFab : FloatingActionButton

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val db = DatabaseHelper(this)
        val data = db.readData()

        btnFab = findViewById(R.id.btnFab)
        recyclerView = findViewById(R.id.recyclerView)
        gridLayoutManager = GridLayoutManager(applicationContext, 2, LinearLayoutManager.VERTICAL, false)
        recyclerView?.layoutManager = gridLayoutManager
        recyclerViewAdapter = RecyclerViewAdapter(applicationContext, data)

        recyclerView?.adapter = recyclerViewAdapter

        btnFab.setOnClickListener{
            var dialog = CustomDialogActivity()
            dialog.show(supportFragmentManager, "customDialog")
        }

//        btnEnter.setOnClickListener{
//            if (etActivity.text.toString().isNotEmpty()) {
//                val id = 0
//                val activity = Activity(etActivity.text.toString(), 0)
//                db.insertData(activity)
//                etActivity.text.clear()
//            } else {
//                Toast.makeText(this, "Please Fill All Data's", Toast.LENGTH_SHORT).show()
//            }
//            val intent = Intent(this, MainActivity::class.java)
//            startActivity(intent)
//            finish()
//        }
//
//        btnDelete.setOnClickListener{
//            db.deleteData()
//            val intent = Intent(this, MainActivity::class.java)
//            startActivity(intent)
//            finish()
//        }

    }
}