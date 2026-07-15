package com.hafidtech.alquran

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.net.Uri
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

        val prayerId = intent.getIntExtra("prayerId", 0)
        val notificationMode = intent.getIntExtra("notificationMode", 0)
        val soundType = intent.getStringExtra("soundType") ?: "adzan"

        val prayerName = when (prayerId) {
            6 -> "Imsak"
            1 -> "Subuh"
            2 -> "Dzuhur"
            3 -> "Ashar"
            4 -> "Maghrib"
            5 -> "Isya"
            else -> null
        }

        if (notificationMode == 3) {
            Log.d("AdzanAlarmReceiver", "Silent mode, skipping notification and adzan")
            return
        }

        val playSound = notificationMode == 0 || notificationMode == 1
        val vibrate = notificationMode == 0 || notificationMode == 2

        showAlertNotification(context, playSound, vibrate, prayerName)

        if (playSound) {
            try {
                val serviceIntent = Intent(context, AdzanService::class.java).apply {
                    putExtra("soundType", soundType)
                }
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
    }

    private fun createAlertChannel(context: Context, playSound: Boolean, vibrate: Boolean) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = if (playSound) NotificationManager.IMPORTANCE_HIGH
                             else NotificationManager.IMPORTANCE_LOW

            val channel = NotificationChannel(
                ALERT_CHANNEL_ID,
                "Waktu Sholat",
                importance
            ).apply {
                description = "Pemberitahuan waktu sholat"
                enableVibration(vibrate)

                if (!playSound) {
                    setSound(null, null)
                }
            }

            try {
                val manager = context.getSystemService(NotificationManager::class.java)
                manager.deleteNotificationChannel(ALERT_CHANNEL_ID)
                manager.createNotificationChannel(channel)
                Log.d("AdzanAlarmReceiver", "Alert channel created (playSound=$playSound, vibrate=$vibrate)")
            } catch (e: Exception) {
                Log.e("AdzanAlarmReceiver", "Failed to create notification channel", e)
            }
        }
    }

    private fun showAlertNotification(context: Context, playSound: Boolean, vibrate: Boolean, prayerName: String? = null) {
        createAlertChannel(context, playSound, vibrate)

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

        val body = if (prayerName != null) "Waktunya sholat $prayerName, jangan sampai terlewat"
                   else "Waktunya sholat, jangan sampai terlewat"

        val builder = NotificationCompat.Builder(context, ALERT_CHANNEL_ID)
            .setContentTitle("Al-Barokah : Quran & Sholat")
            .setContentText(body)
            .setSmallIcon(android.R.drawable.ic_popup_reminder)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setFullScreenIntent(openPendingIntent, true)
            .setAutoCancel(true)
            .setCategory(NotificationCompat.CATEGORY_ALARM)

        var defaults = 0
        if (playSound) defaults = defaults or NotificationCompat.DEFAULT_SOUND
        if (vibrate) defaults = defaults or NotificationCompat.DEFAULT_VIBRATE
        if (defaults != 0) builder.setDefaults(defaults)

        try {
            val manager = context.getSystemService(NotificationManager::class.java)
            manager.notify(ALERT_NOTIFICATION_ID, builder.build())
            Log.d("AdzanAlarmReceiver", "Alert notification shown (playSound=$playSound, vibrate=$vibrate)")
        } catch (e: Exception) {
            Log.e("AdzanAlarmReceiver", "Failed to show notification", e)
        }
    }
}
