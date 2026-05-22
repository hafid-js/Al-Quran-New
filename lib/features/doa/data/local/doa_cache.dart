import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';

part 'doa_cache.g.dart';

@collection
class DoaCache {
  Id id = Isar.autoIncrement;

  late int doaId;
  late String grup;
  late String nama;
  late String ar;
  late String tr;
  late String idn;
  late String tentang;
  late String tagJson;

  Doa toEntity() {
    return Doa(
      id: doaId,
      grup: grup,
      nama: nama,
      ar: ar,
      tr: tr,
      idn: idn,
      tentang: tentang,
      tag: tagJson.isNotEmpty
          ? List<String>.from(jsonDecode(tagJson))
          : [],
    );
  }

  static DoaCache fromEntity(Doa doa) {
    return DoaCache()
      ..doaId = doa.id
      ..grup = doa.grup
      ..nama = doa.nama
      ..ar = doa.ar
      ..tr = doa.tr
      ..idn = doa.idn
      ..tentang = doa.tentang
      ..tagJson = jsonEncode(doa.tag);
  }
}
