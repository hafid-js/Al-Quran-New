import 'package:alquran_new/features/doa/domain/entities/doa.dart';

class DoaListResponseDTO {
  final String status;
  final int total;
  final List<DoaDTO> data;

  const DoaListResponseDTO({
    required this.status,
    required this.total,
    required this.data,
  });

  factory DoaListResponseDTO.fromJson(Map<String, dynamic> json) {
    return DoaListResponseDTO(
      status: json['status'] ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DoaDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DoaDTO {
  final int id;
  final String grup;
  final String nama;
  final String ar;
  final String tr;
  final String idn;
  final String tentang;
  final List<String> tag;

  const DoaDTO({
    required this.id,
    required this.grup,
    required this.nama,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.tentang,
    required this.tag,
  });

  factory DoaDTO.fromJson(Map<String, dynamic> json) {
    return DoaDTO(
      id: (json['id'] as num?)?.toInt() ?? 0,
      grup: json['grup'] ?? '',
      nama: json['nama'] ?? '',
      ar: json['ar'] ?? '',
      tr: json['tr'] ?? '',
      idn: json['idn'] ?? '',
      tentang: json['tentang'] ?? '',
      tag: (json['tag'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Doa toEntity() {
    return Doa(
      id: id,
      grup: grup,
      nama: nama,
      ar: ar,
      tr: tr,
      idn: idn,
      tentang: tentang,
      tag: tag,
    );
  }
}
