import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  /// Diambil dari file `.env` (lihat `.env.example`).
  /// Jangan pernah menaruh key langsung di kode.
  static String get googleApiKey => dotenv.maybeGet('GOOGLE_MAPS_API_KEY') ?? '';
}
