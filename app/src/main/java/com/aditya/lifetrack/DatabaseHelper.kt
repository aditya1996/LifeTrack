package com.aditya.lifetrack

import android.annotation.SuppressLint
import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.widget.Toast

class DatabaseHelper(var context: Context) : SQLiteOpenHelper(context, DATABASENAME, null, 1) {
    override fun onCreate(db: SQLiteDatabase?) {
        val createTable =
            "CREATE TABLE $TABLENAME ($COL_ACT VARCHAR(256) PRIMARY KEY,$COL_DAYS INTEGER)"
        db?.execSQL(createTable)
    }
    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        db?.execSQL("DROP TABLE IF EXISTS $TABLENAME")
        onCreate(db)
    }
    fun insertData(activity: Activity) {
        val database = this.writableDatabase
        val contentValues = ContentValues()
        contentValues.put(COL_ACT, activity.activity)
        contentValues.put(COL_DAYS, activity.days)
        val result = database.insert(TABLENAME, null, contentValues)
        if (result == (0).toLong()) {
            Toast.makeText(context, "Failed", Toast.LENGTH_SHORT).show()
        }
        else {
            Toast.makeText(context, "Success", Toast.LENGTH_SHORT).show()
        }
    }
    @SuppressLint("Range")
    fun readData(): ArrayList<Activity> {
        val list: ArrayList<Activity> = ArrayList()
        val db = this.readableDatabase
        val query = "Select * from $TABLENAME"
        val result = db.rawQuery(query, null)
        if (result.moveToFirst()) {
            do {
                val activity = Activity(result.getString(result.getColumnIndex(COL_ACT)), result.getString(result.getColumnIndex(COL_DAYS)).toInt())
                list.add(activity)
            }
            while (result.moveToNext())
        }
        return list
    }

    fun updateDataByName(name: String) {
        val database = this.writableDatabase
        val contentValues = ContentValues()
    }

    fun deleteData() {
        val database = this.writableDatabase
        database.execSQL("DELETE FROM $TABLENAME")
    }

    companion object{
        // here we have defined variables for our database

        const val DATABASENAME = "ACTIVITY DATABASE"
        const val TABLENAME = "Activities"
        const val COL_ACT = "activity"
        const val COL_DAYS = "days"
    }
}