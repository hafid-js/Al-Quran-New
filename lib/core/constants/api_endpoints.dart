class ApiEndpoints {
  static const baseUrlV1 = "https://equran.id/api";
  static const baseUrlV2 = "https://equran.id/api/v2";

  static const surah = "/surat";

  static const tafsir = "/tafsir";

  static const doa = "/doa";

  static String detailSurah(int nomor) => "$baseUrlV2$surah/$nomor";

  static String tafsirAyat(int nomor) => "$baseUrlV2$tafsir/$nomor";
}