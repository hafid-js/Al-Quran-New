import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:alquran_new/features/doa/domain/entities/doa.dart';

part 'doa_cache.g.dart';

@HiveType(typeId: 5)
class DoaCache extends HiveObject {
  @HiveField(0)
  late int doaId;
  @HiveField(1)
  late String grup;
  @HiveField(2)
  late String nama;
  @HiveField(3)
  late String ar;
  @HiveField(4)
  late String tr;
  @HiveField(5)
  late String idn;
  @HiveField(6)
  late String tentang;
  @HiveField(7)
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
