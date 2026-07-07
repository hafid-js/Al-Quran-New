package com.hafidtech.alquran

import android.content.Context
import android.content.SharedPreferences

object AlarmPreferences {
    private const val PREFS_NAME = "adzan_alarms"
    private const val KEY_ALARMS = "scheduled_alarms"

    private fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    fun saveAlarm(context: Context, prayerId: Int, timestampMillis: Long) {
        val alarms = getAlarms(context).toMutableMap()
        alarms[prayerId] = timestampMillis
        putAlarms(context, alarms)
    }

    fun removeAlarm(context: Context, prayerId: Int) {
        val alarms = getAlarms(context).toMutableMap()
        alarms.remove(prayerId)
        putAlarms(context, alarms)
    }

    fun clearAll(context: Context) {
        prefs(context).edit().remove(KEY_ALARMS).apply()
    }

    fun getAlarms(context: Context): Map<Int, Long> {
        val raw = prefs(context).getString(KEY_ALARMS, null) ?: return emptyMap()
        return raw.split(",").mapNotNull { entry ->
            val parts = entry.split(":")
            if (parts.size == 2) parts[0].toIntOrNull() to parts[1].toLongOrNull()
            else null
        }.filter { it.first != null && it.second != null }
            .associate { it.first!! to it.second!! }
    }

    private fun putAlarms(context: Context, alarms: Map<Int, Long>) {
        val raw = alarms.entries.joinToString(",") { "${it.key}:${it.value}" }
        prefs(context).edit().putString(KEY_ALARMS, raw).apply()
    }
}
