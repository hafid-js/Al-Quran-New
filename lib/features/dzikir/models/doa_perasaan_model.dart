class DoaPerasaanModel {
  final int nomor;
  final String arab;
  final String latin;
  final String arti;
  final String? keterangan;
  final String sumber;

  const DoaPerasaanModel({
    required this.nomor,
    required this.arab,
    required this.latin,
    required this.arti,
    this.keterangan,
    required this.sumber,
  });

factory DoaPerasaanModel.fromJson(Map<String, dynamic> json) {
  return DoaPerasaanModel(
    nomor: int.parse(json['nomor'].toString()),
    arab: json['arab'] ?? '',
    latin: json['latin'] ?? '',
    arti: json['arti'] ?? '',
    keterangan: (json['keterangan'] as String?)?.isEmpty == true
        ? null
        : json['keterangan'],
    sumber: json['sumber'] ?? '',
  );
}
}
