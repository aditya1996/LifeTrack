package com.aditya.lifetrack

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.fragment.app.DialogFragment


class CustomDialogActivity: DialogFragment(){

    private lateinit var etDialogActivity : EditText
    private lateinit var btnDialogEnter: Button
    private lateinit var btnDialogDelete: Button

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val db = DatabaseHelper(requireContext())
        var rootView: View = inflater.inflate(R.layout.activity_custom_dialog, container, false)
        etDialogActivity = rootView.findViewById(R.id.etDialogActivity)
        btnDialogEnter = rootView.findViewById(R.id.btnDialogEnter)
        btnDialogDelete = rootView.findViewById(R.id.btnDialogDelete)

        btnDialogEnter.setOnClickListener{
            if (etDialogActivity.text.toString().isNotEmpty()) {
                val id = 0
                val activity = Activity(etDialogActivity.text.toString(), 0)
                db.insertData(activity)
                etDialogActivity.text.clear()
            } else {
                Toast.makeText(context, "Please Fill All Data's", Toast.LENGTH_SHORT).show()
            }
            val intent = Intent(context, MainActivity::class.java)
            startActivity(intent)
        }

        btnDialogDelete.setOnClickListener{
            db.deleteData()
            val intent = Intent(context, MainActivity::class.java)
            startActivity(intent)
        }

        return rootView
    }
}