class ApiEndpoints {
  static const baseUrlV1 = "https://equran.id/api";
  static const baseUrlV2 = "https://equran.id/api/v2";

  static const surah = "/surat";

  static const tafsir = "/tafsir";

  static const doa = "/doa";

  static const provinsi = "/shalat/provinsi";
  static const kabkota = "/shalat/kabkota";
  static String get provinsiUrl => "$baseUrlV2$provinsi";
  static String get kabkotaUrl => "$baseUrlV2$kabkota";

  static const dzikirBaseUrl = "https://hafidtech.com";
  static const dzikir = "/dzikir.json";
  static String get dzikirUrl => "$dzikirBaseUrl$dzikir";

  static String detailSurah(int nomor) => "$baseUrlV2$surah/$nomor";

  static String tafsirAyat(int nomor) => "$baseUrlV2$tafsir/$nomor";
}