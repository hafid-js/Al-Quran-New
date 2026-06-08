import 'package:alquran_new/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final bgColor = isDark ? const Color(0xFF0F202B) : const Color(0xFFF2F7F6);
    final cardColor = isDark ? const Color(0xFF132E3A) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF2D4A52);
    final mutedColor = isDark ? const Color(0xFF8BA4B4) : const Color(0xFF607D85);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo/hafidtechlogo_rounded.png',
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Al-Barokah",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                _buildHeader(context, primary, mutedColor),
                const SizedBox(height: 20),
                _buildSection(
                  context: context,
                  title: "Syarat & Ketentuan",
                  icon: Icons.description_rounded,
                  content: _syaratContent(),
                  primary: primary,
                  cardColor: cardColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
                const SizedBox(height: 12),
                _buildSection(
                  context: context,
                  title: "Kebijakan Privasi",
                  icon: Icons.privacy_tip_rounded,
                  content: _privasiContent(),
                  primary: primary,
                  cardColor: cardColor,
                  textColor: textColor,
                  mutedColor: mutedColor,
                ),
              ],
            ),
          ),
          _buildBottomBar(context, primary, cardColor, textColor, mutedColor),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color primary, Color mutedColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primary.withAlpha(15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primary.withAlpha(60), width: 0.5),
          ),
          child: Column(
            children: [
              Icon(Icons.verified_user_rounded, size: 40, color: primary),
              const SizedBox(height: 10),
              Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Sebelum menggunakan aplikasi, baca dan setujui ketentuan berikut:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget content,
    required Color primary,
    required Color cardColor,
    required Color textColor,
    required Color mutedColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(icon, color: primary, size: 22),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: textColor,
          ),
        ),
        initiallyExpanded: true,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 4),
          content,
        ],
      ),
    );
  }

  Widget _syaratContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pasal(1, "Penggunaan Aplikasi",
            "Al-Barokah Quran Digital menyediakan layanan dan informasi Islami, termasuk Al-Quran Digital, Jadwal Sholat, Arah Kiblat, Tasbih Digital, Doa Harian, dan fitur Islami lainnya. Aplikasi ini ditujukan untuk penggunaan pribadi dan non-komersial."),
        _pasal(2, "Akurasi Informasi",
            "Kami berupaya menyediakan informasi yang akurat dan terkini. Namun, jadwal sholat, arah kiblat, maupun informasi lainnya dapat dipengaruhi oleh lokasi perangkat, metode perhitungan, dan faktor teknis lainnya. Pengguna disarankan untuk melakukan verifikasi tambahan apabila diperlukan."),
        _pasal(3, "Hak Kekayaan Intelektual",
            "Seluruh desain, logo, tampilan aplikasi, dan elemen yang dibuat oleh pengembang merupakan hak milik pengembang aplikasi. Konten yang berasal dari sumber publik atau referensi pihak lain tetap menjadi hak pemilik masing-masing."),
        _pasal(4, "Larangan Penggunaan",
            "Pengguna tidak diperkenankan untuk: (a) Menggunakan aplikasi untuk tujuan yang melanggar hukum. (b) Menyalin, memodifikasi, atau mendistribusikan aplikasi tanpa izin. (c) Melakukan rekayasa balik terhadap aplikasi. (d) Menggunakan aplikasi dengan cara yang dapat mengganggu fungsi dan keamanan aplikasi."),
        _pasal(5, "Batasan Tanggung Jawab",
            "Aplikasi disediakan 'sebagaimana adanya'. Pengembang tidak memberikan jaminan bahwa aplikasi akan selalu bebas dari kesalahan, gangguan, atau ketidakakuratan. Pengembang tidak bertanggung jawab atas kerugian langsung maupun tidak langsung yang timbul akibat penggunaan aplikasi."),
        _pasal(6, "Pembaruan Aplikasi",
            "Pengembang dapat menambahkan, mengubah, memperbarui, atau menghentikan fitur tertentu sewaktu-waktu tanpa pemberitahuan sebelumnya."),
        _pasal(7, "Privasi dan Izin Pengguna",
            "Aplikasi ini tidak memerlukan login, registrasi, atau akses ke data pribadi seperti foto, video, kontak, dan lainnya. Data yang dikumpulkan terbatas pada lokasi perangkat untuk kebutuhan jadwal sholat dan arah kiblat, serta notifikasi untuk pemberitahuan adzan. Selengkapnya diatur dalam Kebijakan Privasi yang tersedia pada aplikasi."),
        _pasal(8, "Perubahan Syarat dan Ketentuan",
            "Syarat dan Ketentuan ini dapat diperbarui sewaktu-waktu. Perubahan akan berlaku sejak dipublikasikan pada versi terbaru."),
        _pasal(9, "Kontak",
            "Jika Anda memiliki pertanyaan, silakan hubungi Hafid Tech melalui Instagram: @hafidtechcom."),
        _pasal(10, "Persetujuan",
            "Dengan menggunakan Al-Barokah Quran Digital, Anda menyatakan telah membaca, memahami, dan menyetujui seluruh Syarat dan Ketentuan ini."),
      ],
    );
  }

  Widget _privasiContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragraf(
            "Kebijakan Privasi ini menjelaskan bagaimana Al-Barokah Quran Digital mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda."),
        _paragraf(
            "Aplikasi ini tidak memerlukan login, tidak ada formulir pendaftaran, tidak mengakses data pribadi, foto, video, kontak, atau data sensitif lainnya dari perangkat Anda."),
        _paragraf(
            "Izin yang digunakan hanya: (1) Notifikasi — untuk pemberitahuan jadwal adzan, dan (2) Lokasi — untuk menentukan arah kiblat dan jadwal sholat berdasarkan posisi Anda."),
        _paragraf(
            "Aplikasi ini memerlukan akses ke lokasi perangkat Anda untuk menyediakan fitur jadwal sholat dan arah kiblat berdasarkan posisi Anda saat ini. Data lokasi hanya diproses di perangkat dan tidak dikirim ke server kami."),
        _paragraf(
            "Kami juga menggunakan penyimpanan lokal (local storage) untuk menyimpan pengaturan seperti tema, qari default, dan bookmark. Data ini tidak dibagikan kepada pihak ketiga."),
        _paragraf(
            "Aplikasi dapat mengumpulkan data anonim untuk analisis kinerja dan perbaikan layanan. Data ini tidak dapat diidentifikasi secara pribadi."),
        _paragraf(
            "Kami tidak menjual, menukar, atau mentransfer informasi pribadi Anda kepada pihak luar tanpa persetujuan Anda, kecuali diwajibkan oleh hukum."),
        _paragraf(
            "Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu. Perubahan akan diinformasikan melalui pembaruan aplikasi."),
        _paragraf(
            "Jika ada pertanyaan, silakan hubungi kami di Instagram: @hafidtechcom."),
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
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isi,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
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
          fontSize: 13,
          color: Colors.white,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    Color primary,
    Color cardColor,
    Color textColor,
    Color mutedColor,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withAlpha(25),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            title: Text(
              "Saya telah membaca dan menyetujui Syarat & Ketentuan",
              style: TextStyle(fontSize: 13, color: textColor),
            ),
            value: _syaratChecked,
            activeColor: primary,
            onChanged: (v) => setState(() => _syaratChecked = v ?? false),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            title: Text(
              "Saya telah membaca dan menyetujui Kebijakan Privasi",
              style: TextStyle(fontSize: 13, color: textColor),
            ),
            value: _privasiChecked,
            activeColor: primary,
            onChanged: (v) => setState(() => _privasiChecked = v ?? false),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: _canProceed ? _lanjutkan : null,
              style: FilledButton.styleFrom(
                backgroundColor: primary,
                disabledBackgroundColor: primary.withAlpha(80),
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
      ),
    );
  }
}
