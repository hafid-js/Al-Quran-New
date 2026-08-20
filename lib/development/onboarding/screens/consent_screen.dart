
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:alquran_new/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _syaratChecked = false;
  bool _privasiChecked = false;

  bool get _canProceed => _syaratChecked && _privasiChecked;

  void _lanjutkan() {
    if (!_canProceed) return;
    final box = GetStorage();
    box.write('has_consented', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#F9F5EF"),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex("#256980"),
        surfaceTintColor: HexColor.fromHex("#256980"),
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                _buildSection(
                  title: "Syarat & Ketentuan",
                  icon: Iconsax.document_text,
                  content: _syaratContent(),
                ),
                const SizedBox(height: 12),
                _buildSection(
                  title: "Kebijakan Privasi",
                  icon: Iconsax.shield,
                  content: _privasiContent(),
                ),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#256980"),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/icon/albarokah.png',
              width: 56,
              height: 56,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Selamat Datang",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Baca dan setujui ketentuan berikut\nuntuk melanjutkan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withAlpha(200),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: HexColor.fromHex("#256980"),
          collapsedIconColor: HexColor.fromHex("#256980"),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#256980").withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: HexColor.fromHex("#256980"), size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: HexColor.fromHex("#2D4A52"),
            ),
          ),
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey.withAlpha(30)),
            const SizedBox(height: 4),
            content,
          ],
        ),
      ),
    );
  }

  Widget _syaratContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pasal(
          1,
          "Penggunaan Aplikasi",
          "Al-Barokah Quran Digital menyediakan layanan dan informasi Islami, termasuk Al-Quran Digital, Jadwal Sholat, Arah Kiblat, Tasbih Digital, Doa Harian, dan fitur Islami lainnya. Aplikasi ini ditujukan untuk penggunaan pribadi dan non-komersial.",
        ),
        _pasal(
          2,
          "Akurasi Informasi",
          "Kami berupaya menyediakan informasi yang akurat dan terkini. Namun, jadwal sholat, arah kiblat, maupun informasi lainnya dapat dipengaruhi oleh lokasi perangkat, metode perhitungan, dan faktor teknis lainnya.",
        ),
        _pasal(
          3,
          "Hak Kekayaan Intelektual",
          "Seluruh desain, logo, tampilan aplikasi, dan elemen yang dibuat oleh pengembang merupakan hak milik pengembang aplikasi. Konten yang berasal dari sumber publik atau referensi pihak lain tetap menjadi hak pemilik masing-masing.",
        ),
        _pasal(
          4,
          "Larangan Penggunaan",
          "Pengguna tidak diperkenankan untuk: (a) Menggunakan aplikasi untuk tujuan yang melanggar hukum. (b) Menyalin, memodifikasi, atau mendistribusikan aplikasi tanpa izin. (c) Melakukan rekayasa balik terhadap aplikasi.",
        ),
        _pasal(
          5,
          "Batasan Tanggung Jawab",
          "Aplikasi disediakan 'sebagaimana adanya'. Pengembang tidak memberikan jaminan bahwa aplikasi akan selalu bebas dari kesalahan, gangguan, atau ketidakakuratan.",
        ),
        _pasal(
          6,
          "Pembaruan Aplikasi",
          "Pengembang dapat menambahkan, mengubah, memperbarui, atau menghentikan fitur tertentu sewaktu-waktu tanpa pemberitahuan sebelumnya.",
        ),
        _pasal(
          7,
          "Privasi dan Izin Pengguna",
          "Aplikasi ini tidak memerlukan login, registrasi, atau akses ke data pribadi. Data yang dikumpulkan terbatas pada lokasi perangkat untuk kebutuhan jadwal sholat dan arah kiblat, serta notifikasi untuk pemberitahuan adzan.",
        ),
        _pasal(
          8,
          "Perubahan Syarat dan Ketentuan",
          "Syarat dan Ketentuan ini dapat diperbarui sewaktu-waktu. Perubahan akan berlaku sejak dipublikasikan pada versi terbaru.",
        ),
        _pasal(
          9,
          "Kontak",
          "Jika Anda memiliki pertanyaan, silakan hubungi Hafid Tech melalui Instagram: @hafidtechcom.",
        ),
        _pasal(
          10,
          "Persetujuan",
          "Dengan menggunakan Al-Barokah Quran Digital, Anda menyatakan telah membaca, memahami, dan menyetujui seluruh Syarat dan Ketentuan ini.",
        ),
      ],
    );
  }

  Widget _privasiContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragraf(
          "Kebijakan Privasi ini menjelaskan bagaimana Al-Barokah Quran Digital mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda.",
        ),
        _paragraf(
          "Aplikasi ini tidak memerlukan login, tidak ada formulir pendaftaran, tidak mengakses data pribadi, foto, video, kontak, atau data sensitif lainnya dari perangkat Anda.",
        ),
        _paragraf(
          "Izin yang digunakan hanya: (1) Notifikasi — untuk pemberitahuan jadwal adzan, dan (2) Lokasi — untuk menentukan arah kiblat dan jadwal sholat berdasarkan posisi Anda.",
        ),
        _paragraf(
          "Aplikasi ini memerlukan akses ke lokasi perangkat Anda untuk menyediakan fitur jadwal sholat dan arah kiblat. Data lokasi hanya diproses di perangkat dan tidak dikirim ke server kami.",
        ),
        _paragraf(
          "Kami juga menggunakan penyimpanan lokal (local storage) untuk menyimpan pengaturan seperti tema, qari default, dan bookmark. Data ini tidak dibagikan kepada pihak ketiga.",
        ),
        _paragraf(
          "Aplikasi dapat mengumpulkan data anonim untuk analisis kinerja dan perbaikan layanan. Data ini tidak dapat diidentifikasi secara pribadi.",
        ),
        _paragraf(
          "Kami tidak menjual, menukar, atau mentransfer informasi pribadi Anda kepada pihak luar tanpa persetujuan Anda, kecuali diwajibkan oleh hukum.",
        ),
        _paragraf(
          "Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan diinformasikan melalui pembaruan aplikasi.",
        ),
        _paragraf(
          "Jika ada pertanyaan, silakan hubungi kami di Instagram: @hafidtechcom.",
        ),
      ],
    );
  }

  Widget _pasal(int nomor, String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$nomor. $judul",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: HexColor.fromHex("#D39D52"),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isi,
            style: TextStyle(
              fontSize: 12,
              color: HexColor.fromHex("#5a7b8a"),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paragraf(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: HexColor.fromHex("#5a7b8a"),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      controlAffinity: ListTileControlAffinity.leading,

      title: Text(
        "Saya menyetujui Syarat & Ketentuan",
        style: TextStyle(
          fontSize: 13,
          color: HexColor.fromHex("#2D4A52"),
        ),
      ),

      value: _syaratChecked,

      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return HexColor.fromHex("#D39D52");
        }
        return Colors.white;
      }),

      checkColor: Colors.white,

      side: BorderSide(
        color: HexColor.fromHex("#256980"),
        width: 1.5,
      ),

      onChanged: (v) {
        setState(() {
          _syaratChecked = v ?? false;
        });
      },
    ),

    CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      controlAffinity: ListTileControlAffinity.leading,

      title: Text(
        "Saya menyetujui Kebijakan Privasi",
        style: TextStyle(
          fontSize: 13,
          color: HexColor.fromHex("#2D4A52"),
        ),
      ),

      value: _privasiChecked,

      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return HexColor.fromHex("#D39D52");
        }
        return Colors.white;
      }),

      checkColor: Colors.white,

      side: BorderSide(
        color: HexColor.fromHex("#256980"),
        width: 1.5,
      ),

      onChanged: (v) {
        setState(() {
          _privasiChecked = v ?? false;
        });
      },
    ),

    const SizedBox(height: 8),

    SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: _canProceed ? _lanjutkan : null,
        style: FilledButton.styleFrom(
          backgroundColor: HexColor.fromHex("#D39D52"),
          disabledBackgroundColor:
              HexColor.fromHex("#D39D52").withAlpha(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Lanjutkan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _canProceed ? Colors.white : Colors.white60,
          ),
        ),
      ),
    ),
  ],
)
    );
  }
}
