import 'dart:convert';

import 'package:alquran_new/core/network/api_endpoints.dart';
import 'package:alquran_new/features/alquran/models/surah_model.dart';
import 'package:http/http.dart' as http;

class SurahService {
  Future<List<Surah>> getAllSurah() async {
    final url = Uri.parse("${ApiEndpoints.baseUrlV2}${ApiEndpoints.surah}");

    final res = await http.get(url);

    final body = jsonDecode(res.body);

    final List data = body["data"];

    return data.map((e) => Surah.fromJson(e)).toList();
  }
}