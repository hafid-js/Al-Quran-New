package com.hafidtech.alquran

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return

        Log.d("BootReceiver", "Boot completed, rescheduling alarms")

        val alarms = AlarmPreferences.getAlarms(context)
        if (alarms.isEmpty()) {
            Log.d("BootReceiver", "No alarms to reschedule")
            return
        }

        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val now = System.currentTimeMillis()

        for ((prayerId, timestamp) in alarms) {
            if (timestamp <= now) {
                AlarmPreferences.removeAlarm(context, prayerId)
                Log.d("BootReceiver", "Skipping past alarm: prayerId=$prayerId")
                continue
            }

            val alarmIntent = Intent(context, AdzanAlarmReceiver::class.java).apply {
                putExtra("prayerId", prayerId)
            }
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                prayerId,
                alarmIntent,
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                    PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                else PendingIntent.FLAG_UPDATE_CURRENT
            )

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                if (alarmManager.canScheduleExactAlarms()) {
                    alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestamp, pendingIntent)
                } else {
                    alarmManager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestamp, pendingIntent)
                }
            } else {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestamp, pendingIntent)
            }

            Log.d("BootReceiver", "Rescheduled alarm: prayerId=$prayerId at $timestamp")
        }
    }
}
