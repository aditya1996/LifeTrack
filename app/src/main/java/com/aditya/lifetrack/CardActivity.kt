package com.aditya.lifetrack

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

class CardActivity : AppCompatActivity() {

    lateinit var tvCardText: TextView
    var name = "Custom Name"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_card_view)

        tvCardText = findViewById(R.id.tvCardText)

        if(intent != null) {
            name = intent.getStringExtra("name").toString()
            tvCardText.text = name
        }
    }
}