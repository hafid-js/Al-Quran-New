class ApiEndpoints {
  static const baseUrl = "https://equran.id/api/v2";

  static const surah = "/surat";

  static const tafsir = "/tafsir";

  static String detailSurah(int nomor) => "$baseUrl$surah/$nomor";

  static String tafsirAyat(int nomor) => "$baseUrl$tafsir/$nomor";
}