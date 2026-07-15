package com.hafidtech.alquran

import android.content.Context
import android.content.SharedPreferences

object AlarmPreferences {
    private const val PREFS_NAME = "adzan_alarms"
    private const val KEY_ALARMS = "scheduled_alarms"
    private const val KEY_ENABLED_PRAYERS = "enabled_prayers"
    private const val KEY_NOTIFICATION_MODE = "global_notification_mode"
    private const val KEY_SOUND_TYPE = "global_sound_type"

    private fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    fun saveAlarm(context: Context, prayerId: Int, timestampMillis: Long) {
        val alarms = getAlarms(context).toMutableMap()
        alarms[prayerId] = timestampMillis
        putAlarms(context, alarms)
        setPrayerEnabled(context, prayerId, true)
    }

    fun saveSettings(context: Context, notificationMode: Int, soundType: String) {
        prefs(context).edit()
            .putInt(KEY_NOTIFICATION_MODE, notificationMode)
            .putString(KEY_SOUND_TYPE, soundType)
            .apply()
    }

    fun getNotificationMode(context: Context): Int =
        prefs(context).getInt(KEY_NOTIFICATION_MODE, 0)

    fun getSoundType(context: Context): String =
        prefs(context).getString(KEY_SOUND_TYPE, "adzan") ?: "adzan"

    fun removeAlarm(context: Context, prayerId: Int) {
        val alarms = getAlarms(context).toMutableMap()
        alarms.remove(prayerId)
        putAlarms(context, alarms)
        setPrayerEnabled(context, prayerId, false)
    }

    fun setPrayerEnabled(context: Context, prayerId: Int, enabled: Boolean) {
        val enabledSet = getEnabledPrayers(context).toMutableSet()
        if (enabled) enabledSet.add(prayerId)
        else enabledSet.remove(prayerId)
        val raw = enabledSet.joinToString(",")
        prefs(context).edit().putString(KEY_ENABLED_PRAYERS, raw).apply()
    }

    fun isPrayerEnabled(context: Context, prayerId: Int): Boolean {
        return getEnabledPrayers(context).contains(prayerId)
    }

    private fun getEnabledPrayers(context: Context): Set<Int> {
        val raw = prefs(context).getString(KEY_ENABLED_PRAYERS, null) ?: return emptySet()
        return raw.split(",").mapNotNull { it.toIntOrNull() }.toSet()
    }

    fun clearAll(context: Context) {
        prefs(context).edit()
            .remove(KEY_ALARMS)
            .remove(KEY_ENABLED_PRAYERS)
            .apply()
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
