package com.hafidtech.alquran

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat

class AdzanAlarmReceiver : BroadcastReceiver() {
    companion object {
        const val ALERT_CHANNEL_ID = "adzan_alert_channel"
        const val ALERT_NOTIFICATION_ID = 2001
        const val EXTRA_NAVIGATE = "navigate_to_adzan"
    }

    override fun onReceive(context: Context, intent: Intent) {
        Log.d("AdzanAlarmReceiver", "Alarm received")

        showAlertNotification(context)

        try {
            val serviceIntent = Intent(context, AdzanService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
            Log.d("AdzanAlarmReceiver", "AdzanService started successfully")
        } catch (e: Exception) {
            Log.e("AdzanAlarmReceiver", "Failed to start AdzanService", e)
        }
    }

    private fun createAlertChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                ALERT_CHANNEL_ID,
                "Waktu Sholat",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Pemberitahuan waktu sholat"
                enableVibration(true)
            }

            try {
                val manager = context.getSystemService(NotificationManager::class.java)
                manager.deleteNotificationChannel(ALERT_CHANNEL_ID)
                manager.createNotificationChannel(channel)
                Log.d("AdzanAlarmReceiver", "Alert channel created (default sound)")
            } catch (e: Exception) {
                Log.e("AdzanAlarmReceiver", "Failed to create notification channel", e)
            }
        }
    }

    private fun showAlertNotification(context: Context) {
        createAlertChannel(context)

        val openIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)?.apply {
            putExtra(EXTRA_NAVIGATE, true)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val openPendingIntent = PendingIntent.getActivity(
            context,
            0,
            openIntent,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            else PendingIntent.FLAG_UPDATE_CURRENT
        )

        val notification = NotificationCompat.Builder(context, ALERT_CHANNEL_ID)
            .setContentTitle("Al-Barokah : Quran & Sholat")
            .setContentText("Waktunya sholat, jangan sampai terlewat")
            .setSmallIcon(android.R.drawable.ic_popup_reminder)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setFullScreenIntent(openPendingIntent, true)
            .setAutoCancel(true)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .setDefaults(NotificationCompat.DEFAULT_SOUND or NotificationCompat.DEFAULT_VIBRATE)
            .build()

        try {
            val manager = context.getSystemService(NotificationManager::class.java)
            manager.notify(ALERT_NOTIFICATION_ID, notification)
            Log.d("AdzanAlarmReceiver", "Alert notification shown (default sound)")
        } catch (e: Exception) {
            Log.e("AdzanAlarmReceiver", "Failed to show notification", e)
        }
    }
}
