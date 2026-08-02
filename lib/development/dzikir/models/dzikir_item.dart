class DzikirItem {
  final int id;
  final String kategori;
  final String judul;
  final String arab;
  final String latin;
  final String arti;
  final String? penjelasan;
  final String sumber;
  final int jumlah;

  const DzikirItem({
    required this.id,
    required this.kategori,
    required this.judul,
    required this.arab,
    required this.latin,
    required this.arti,
    this.penjelasan,
    required this.sumber,
    required this.jumlah,
  });

  factory DzikirItem.fromJson(Map<String, dynamic> json) {
    return DzikirItem(
      id: json['id'] as int,
      kategori: json['kategori'] as String,
      judul: json['judul'] as String,
      arab: json['arab'] as String,
      latin: json['latin'] as String,
      arti: json['arti'] as String,
      penjelasan: (json['penjelasan'] as String?)?.isEmpty == true
          ? null
          : json['penjelasan'] as String?,
      sumber: json['sumber'] as String,
      jumlah: json['jumlah'] as int,
    );
  }
}
