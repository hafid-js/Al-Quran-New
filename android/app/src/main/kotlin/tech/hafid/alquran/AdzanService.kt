package com.hafidtech.alquran

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.util.Log
import androidx.core.app.NotificationCompat

class AdzanService : Service() {
    companion object {
        const val CHANNEL_ID = "adzan_foreground_channel"
        const val NOTIFICATION_ID = 1001
        const val TAG = "AdzanService"
        const val ACTION_STOP = "com.hafidtech.alquran.ACTION_STOP_ADZAN"

        var isPlaying = false
            private set

        private var mediaPlayer: MediaPlayer? = null
        private var wakeLock: PowerManager.WakeLock? = null
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                stopAdzan()
                return START_NOT_STICKY
            }
            else -> {
                try {
                    val notification = createNotification()
                    startForeground(NOTIFICATION_ID, notification)
                    Log.d(TAG, "Foreground service started")
                } catch (e: Exception) {
                    Log.e(TAG, "Failed to start foreground service", e)
                    stopSelf()
                    return START_NOT_STICKY
                }
                playAdzan()
            }
        }
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Adzan",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Adzan playback service"
                setSound(null, null)
            }
            try {
                val manager = getSystemService(NotificationManager::class.java)
                manager.createNotificationChannel(channel)
            } catch (e: Exception) {
                Log.e(TAG, "Failed to create notification channel", e)
            }
        }
    }

    private fun createNotification(): Notification {
        val stopIntent = Intent(this, AdzanService::class.java).apply {
            action = ACTION_STOP
        }
        val stopPendingIntent = PendingIntent.getService(
            this, 0, stopIntent,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            else PendingIntent.FLAG_UPDATE_CURRENT
        )

        val openIntent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
            putExtra(AdzanAlarmReceiver.EXTRA_NAVIGATE, true)
        }
        val openPendingIntent = PendingIntent.getActivity(
            this, 1, openIntent,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            else PendingIntent.FLAG_UPDATE_CURRENT
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Adzan")
            .setContentText("Sedang memutar adzan...")
            .setSmallIcon(android.R.drawable.ic_media_play)
            .setOngoing(true)
            .setContentIntent(openPendingIntent)
            .addAction(android.R.drawable.ic_media_pause, "Stop", stopPendingIntent)
            .build()
    }

    private fun getAdzanUri(): Uri {
        val resId = resources.getIdentifier("adzan_makkah", "raw", packageName)
        return if (resId != 0) {
            Uri.parse("android.resource://$packageName/$resId")
        } else {
            Log.w(TAG, "adzan_makkah resource not found")
            Uri.EMPTY
        }
    }

    private fun playAdzan() {
        isPlaying = true
        Handler(Looper.getMainLooper()).postDelayed({
            try {
                val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
                val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                val targetVolume = (maxVolume * 0.7).toInt().coerceIn(0, maxVolume)
                audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, targetVolume, 0)

                wakeLock = (getSystemService(POWER_SERVICE) as PowerManager)
                    .newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "AdzanService:AudioLock")
                wakeLock?.acquire(10 * 60 * 1000L)

                val adzanUri = getAdzanUri()
                if (adzanUri == Uri.EMPTY) {
                    Log.e(TAG, "Adzan audio resource not found")
                    isPlaying = false
                    releaseWakeLock()
                    stopSelf()
                    return@postDelayed
                }

                mediaPlayer?.release()
                mediaPlayer = MediaPlayer().apply {
                    setAudioAttributes(
                        AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_ALARM)
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            .build()
                    )
                    setDataSource(applicationContext, adzanUri)
                    setOnPreparedListener {
                        start()
                        AdzanService.isPlaying = true
                        Log.d(TAG, "Adzan started playing")
                    }
                    setOnCompletionListener {
                        Log.d(TAG, "Adzan finished playing")
                        AdzanService.isPlaying = false
                        val manager = getSystemService(NotificationManager::class.java)
                        manager.cancel(AdzanAlarmReceiver.ALERT_NOTIFICATION_ID)
                        releaseWakeLock()
                        stopSelf()
                    }
                    setOnErrorListener { mp, what, extra ->
                        Log.e(TAG, "MediaPlayer error: what=$what extra=$extra")
                        AdzanService.isPlaying = false
                        releaseWakeLock()
                        stopSelf()
                        true
                    }
                    prepareAsync()
                }
            } catch (e: Exception) {
                Log.e(TAG, "Failed to play adzan", e)
                isPlaying = false
                releaseWakeLock()
                stopSelf()
            }
        }, 2000)
    }

    private fun releaseWakeLock() {
        try {
            wakeLock?.let {
                if (it.isHeld) {
                    it.release()
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error releasing wake lock", e)
        }
        wakeLock = null
    }

    private fun stopAdzan() {
        mediaPlayer?.let { mp ->
            try {
                if (mp.isPlaying) {
                    mp.stop()
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error stopping media player", e)
            }
            try {
                mp.release()
            } catch (e: Exception) {
                Log.e(TAG, "Error releasing media player", e)
            }
        }
        mediaPlayer = null
        isPlaying = false
        releaseWakeLock()
        try {
            val manager = getSystemService(NotificationManager::class.java)
            manager.cancel(AdzanAlarmReceiver.ALERT_NOTIFICATION_ID)
        } catch (e: Exception) {
            Log.e(TAG, "Error cancelling alert notification", e)
        }
        try {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping foreground", e)
        }
        stopSelf()
    }

    override fun onDestroy() {
        stopAdzan()
        super.onDestroy()
    }
}
