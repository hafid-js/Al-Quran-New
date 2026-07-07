package com.hafidtech.alquran

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val VOLUME_CHANNEL = "com.hafidtech.alquran/volume"
    private val ADZAN_CHANNEL = "com.hafidtech.alquran/adzan"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VOLUME_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setMediaVolume") {
                val fraction = call.argument<Double>("fraction") ?: 0.7
                val audioManager = getSystemService(AudioManager::class.java)
                val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                val targetVolume = (maxVolume * fraction).toInt().coerceIn(0, maxVolume)
                audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, targetVolume, 0)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ADZAN_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "scheduleAlarm" -> {
                    val prayerId = call.argument<Int>("prayerId")
                    val timestampMillis = call.argument<Long>("timestampMillis")
                    if (prayerId != null && timestampMillis != null) {
                        scheduleAlarm(prayerId, timestampMillis)
                        result.success(true)
                    } else {
                        result.error("INVALID_ARG", "Missing required arguments", null)
                    }
                }
                "cancelAlarm" -> {
                    val prayerId = call.argument<Int>("prayerId")
                    if (prayerId != null) {
                        cancelAlarm(prayerId)
                        result.success(true)
                    } else {
                        result.error("INVALID_ARG", "prayerId required", null)
                    }
                }
                "cancelAllAlarms" -> {
                    cancelAllAlarms()
                    result.success(true)
                }
                "stopAdzan" -> {
                    val intent = Intent(this, AdzanService::class.java).apply {
                        action = AdzanService.ACTION_STOP
                    }
                    startService(intent)
                    result.success(true)
                }
                "isAdzanPlaying" -> result.success(AdzanService.isPlaying)
                else -> result.notImplemented()
            }
        }
    }

    private fun scheduleAlarm(prayerId: Int, timestampMillis: Long) {
        AlarmPreferences.saveAlarm(this, prayerId, timestampMillis)
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AdzanAlarmReceiver::class.java).apply {
            putExtra("prayerId", prayerId)
        }
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            prayerId,
            intent,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            else PendingIntent.FLAG_UPDATE_CURRENT
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (alarmManager.canScheduleExactAlarms()) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestampMillis, pendingIntent)
            } else {
                alarmManager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestampMillis, pendingIntent)
            }
        } else {
            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, timestampMillis, pendingIntent)
        }
    }

    private fun cancelAlarm(prayerId: Int) {
        AlarmPreferences.removeAlarm(this, prayerId)
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, AdzanAlarmReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            prayerId,
            intent,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_NO_CREATE
            else PendingIntent.FLAG_NO_CREATE
        )
        pendingIntent?.let {
            alarmManager.cancel(it)
            it.cancel()
        }
    }

    private fun cancelAllAlarms() {
        AlarmPreferences.clearAll(this)
        for (id in 1..6) {
            cancelAlarm(id)
        }
    }
}
