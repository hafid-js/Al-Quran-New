# Flutter specific
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.engine.** { *; }

# Keep audio_session
-keep class com.ryanheise.audio_session.** { *; }

# Keep connectivity_plus
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# Keep flutter_compass
-keep class com.hemanthraj.fluttercompass.** { *; }

# Keep flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep flutter_timezone
-keep class net.wolverinebeach.flutter_timezone.** { *; }

# Keep geolocator
-keep class com.baseflow.geolocator.** { *; }

# Keep jni / jni_flutter
-keep class com.github.dart_lang.jni.** { *; }
-keep class com.github.dart_lang.jni_flutter.** { *; }

# Keep just_audio
-keep class com.ryanheise.just_audio.** { *; }

# Keep path_provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# Keep sqflite
-keep class com.tekartik.sqflite.** { *; }

# Play Core (for Flutter deferred components)
-dontwarn com.google.android.play.core.*
