import 'dart:convert';

import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/features/doa/models/doa_model.dart';
import 'package:http/http.dart' as http;

class DoaService {
  Future<List<Doa>> getAllDoa() async {
    final url = Uri.parse("${ApiEndpoints.baseUrlV1}${ApiEndpoints.doa}");

    final res = await http.get(url);

    final body = jsonDecode(res.body);

    final List data = body["data"];

    return data.map((e) => Doa.fromJson(e)).toList();
  }
}