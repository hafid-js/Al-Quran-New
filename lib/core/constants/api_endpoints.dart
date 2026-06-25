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

  static const githubRawBase = "https://raw.githubusercontent.com/hafid-js/al-quran-data-json/master";
  static const dzikirPagiSugro = "$githubRawBase/dzikir_pagi_sugro.json";
  static const dzikirPetangSugro = "$githubRawBase/dzikir_petang_sugro.json";
  static const dzikirPagiKubro = "$githubRawBase/dzikir_pagi_kubro.json";
  static const dzikirPetangKubro = "$githubRawBase/dzikir_petang_kubro.json";

  static String detailSurah(int nomor) => "$baseUrlV2$surah/$nomor";

  static String tafsirAyat(int nomor) => "$baseUrlV2$tafsir/$nomor";
}