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

        createAlertChannel(context)
        showAlertNotification(context)

        val serviceIntent = Intent(context, AdzanService::class.java)
        context.startForegroundService(serviceIntent)
    }

    private fun createAlertChannel(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                ALERT_CHANNEL_ID,
                "Waktu Sholat",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Pemberitahuan waktu sholat"
            }
            val manager = context.getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    private fun showAlertNotification(context: Context) {
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
            .setContentTitle("Waktu Sholat")
            .setContentText("Saatnya sholat, yuk buka aplikasi")
            .setSmallIcon(android.R.drawable.ic_popup_reminder)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setFullScreenIntent(openPendingIntent, true)
            .setAutoCancel(true)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .build()

        val manager = context.getSystemService(NotificationManager::class.java)
        manager.notify(ALERT_NOTIFICATION_ID, notification)
    }
}
