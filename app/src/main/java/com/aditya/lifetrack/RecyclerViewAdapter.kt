package com.aditya.lifetrack

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.core.content.ContextCompat.startActivity
import androidx.recyclerview.widget.RecyclerView


class RecyclerViewAdapter (val context: Context, private val activities: ArrayList<Activity>) : RecyclerView.Adapter<RecyclerViewAdapter.ItemHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): ItemHolder {
        val itemHolder = LayoutInflater.from(parent.context).inflate(R.layout.activity_card_single, parent, false)
        return ItemHolder(itemHolder)
    }

    override fun onBindViewHolder(holder: ItemHolder, position: Int) {
        var activity = activities[position]
        holder.activityText?.text = activity?.activity
        holder.activityDays?.text = activity?.days.toString()

        holder.itemView.setOnClickListener(View.OnClickListener {
            val intent = Intent(context, CardActivity::class.java)
            val name = activity.activity
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.putExtra("name", name)
            context.startActivity(intent)

        })
    }

    override fun getItemCount(): Int {
        return activities.size
    }

    class ItemHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var activityText: TextView? = itemView.findViewById<TextView>(R.id.tvActivity)
        var activityDays: TextView? = itemView.findViewById<TextView>(R.id.tvDays)
    }

}