class DoaListResponse {
  final String status;
  final int total;
  final List<Doa> data;

  const DoaListResponse({
    required this.status,
    required this.total,
    required this.data,
  });

  factory DoaListResponse.fromJson(Map<String, dynamic> json) {
    return DoaListResponse(
      status: json['status'] ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Doa.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'total': total,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class Doa {
  final int id;
  final String grup;
  final String nama;
  final String ar;
  final String tr;
  final String idn;
  final String tentang;
  final List<String> tag;

  const Doa({
    required this.id,
    required this.grup,
    required this.nama,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.tentang,
    required this.tag,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'grup': grup,
        'nama': nama,
        'ar': ar,
        'tr': tr,
        'idn': idn,
        'tentang': tentang,
        'tag': tag,
      };
}