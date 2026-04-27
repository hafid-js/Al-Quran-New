import 'package:alquran_new/utils/constants/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailSuratScreen extends StatefulWidget {
  const DetailSuratScreen({super.key});

  @override
  State<DetailSuratScreen> createState() => _DetailSuratScreenState();
}

class _DetailSuratScreenState extends State<DetailSuratScreen> {
  final ExpansibleController controller = ExpansibleController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: HexColor.fromHex("#0c1d27"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor.fromHex("#23867c"),
                    HexColor.fromHex("#37b0a5"),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(
                                  "#19554d",
                                ).withAlpha(140),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.arrow_circle_left_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),

                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#19554d").withAlpha(140),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.list_alt_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "الفاتحة",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Al-Fatihah",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Pembukaan",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mosque,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Makkiyah",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.feed_outlined,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "7 Ayat",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: HexColor.fromHex("#132e3a"),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor.fromHex("#2dc8b9"),
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#28ab9e"),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.brightness_5_sharp,
                                    color: HexColor.fromHex(
                                      "#28ab9e",
                                    ).withAlpha(90),
                                    size: 40,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.isExpanded) {
                                        controller.collapse();
                                      } else {
                                        controller.expand();
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: HexColor.fromHex("#1a3a4a"),
                                      ),
                                      child: Icon(
                                        Icons.menu_book_rounded,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: HexColor.fromHex("#1a3a4a"),
                                    ),
                                    child: Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: HexColor.fromHex("#2dc8b9"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Divider(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(90),
                                thickness: 0.1,
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bismillāhir-raḥmānir-raḥīm(i).",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#228276"),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Dengan nama Allah Yang Maha Pengasih lagi Maha Penyayang.",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#7c97a6"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ExpansionTile(
                    controller: controller,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    minTileHeight: 0,
                    visualDensity: VisualDensity.compact,
                    shape: Border(),
                    collapsedShape: Border(),
                    showTrailingIcon: false,
                    title: SizedBox.shrink(),
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(10),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Tafsir",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Text(
                              ''' Surah al-Fatihah dimulai dengan Basmalah

Ada beberapa pendapat ulama berkenaan dengan Basmalah yang terdapat pada permulaan surah Al-Fatihah. Di antara pendapat-pendapat itu, yang termasyhur ialah:

1.Basmalah adalah ayat tersendiri, diturunkan Allah untuk jadi kepala masing-masing surah, dan pembatas antara satu surah dengan surah yang lain. Jadi dia bukanlah satu ayat dari al-Fatihah atau dari surah yang lain, yang dimulai dengan Basmalah itu. Ini pendapat Imam Malik beserta ahli qiraah dan fuqaha (ahli fikih) Medinah, Basrah dan Syam, dan juga pendapat Imam Abu Hanifah dan pengikut-pengikutnya. Sebab itu menurut Imam Abu Hanifah, Basmalah itu tidak dikeraskan membacanya dalam salat, bahkan Imam Malik tidak membaca Basmalah sama sekali.

Hadis Nabi saw:

Dari Anas bin Malik, dia berkata, "Saya salat di belakang Nabi saw, Abu Bakar, Umar dan Usman. Mereka memulai dengan al-hamdulillahi rabbil 'alamin, tidak menyebut Bismillahirrahmanirrahim di awal bacaan, dan tidak pula di akhirnya."(Riwayat al-Bukhari dan Muslim).

2.Basmalah adalah salah satu ayat dari al-Fatihah, dan pada surah an-Naml/27:30, /27:30) yang dimulai dengan Basmalah. Ini adalah pendapat Imam Syafi'i beserta ahli qiraah Mekah dan Kufah. Sebab itu menurut mereka Basmalah itu dibaca dengan suara keras dalam salat (jahar). Dalil-dalil yang menunjukkan hal itu antara lain Hadis Nabi saw:

Dari Ibnu 'Abbas, ia berkata, Rasulullah saw mengeraskan bacaan Bismillahirrahmanirrahim. (Riwayat al-hakim dalam al-Mustadrak dan menurutnya, hadis ini sahih)

Dari Ummu Salamah, katanya, Rasulullah saw berhenti berkali-kali dalam bacaanya Bismillahirrahmanirrahim, al-hamdulillahi Rabbil- 'alamin, ar-Rahmanir-rahim, Maliki Yaumid-din. (Riwayat Ahmad, Abu Daud, Ibnu Khuzaimah dan al-hakim. Menurut ad-Daruqutni, sanad hadis ini sahih).

Abu Hurairah juga salat dan mengeraskan bacaan basmalah. Setelah selesai salat, dia berkata, "Saya ini adalah orang yang salatnya paling mirip dengan Rasulullah." Muawiyah juga pernah salat di Medinah tanpa mengeraskan suara basmalah. Ia diprotes oleh para sahabat lain yang hadir disitu. Akhirnya pada salat berikutnya Muawiyah mengeraskan bacaan basmalah.

Kalau kita perhatikan bahwa sahabat-sahabat Rasulullah saw telah sependapat menuliskan Basmalah pada permulaan surah dari surah Al-Qur'an, kecuali surah at-Taubah (karena memang dari semula turunnya tidak dimulai dengan Basmalah) dan bahwa Rasulullah saw melarang menuliskan sesuatu yang bukan Al-Qur'an agar tidak bercampur aduk dengan Al-Qur'an, sehingga mereka tidak menuliskan 'amin pada akhir surah al-Fatihah, maka Basmalah itu adalah salah satu ayat dari Al-Qur'an. Dengan kata lain, bahwa "basmalah-basmalah" yang terdapat di dalam Al-Qur'an adalah ayat-ayat Al-Qur'an, lepas dari pendapat apakah satu ayat dari al-Fatihah atau dari surah lain, yang dimulai dengan Basmalah atau tidak.

Sebagaimana disebutkan di atas bahwa surah al-Fatihah itu terdiri dari tujuh ayat. Mereka yang berpendapat bahwa Basmalah itu tidak termasuk satu ayat dari al-Fatihah, memandang:

adalah salah satu ayat, dengan demikian ayat-ayat al-Fatihah itu tetap tujuh.

"Dengan nama Allah" maksudnya "Dengan nama Allah saya baca atau saya mulai". Seakan-akan Nabi berkata, "Saya baca surah ini dengan menyebut nama Allah, bukan dengan menyebut nama saya sendiri, sebab ia wahyu dari Tuhan, bukan dari saya sendiri." Maka Basmalah di sini mengandung arti bahwa Al-Qur'an itu wahyu dari Allah, bukan karangan Muhammad saw dan Muhammad itu hanyalah seorang Pesuruh Allah yang dapat perintah menyampaikan Al-Qur'an kepada manusia.

Makna kata Allah

Allah adalah nama bagi Zat yang ada dengan sendirinya (wajibul-wujud). Kata "Allah" hanya dipakai oleh bangsa Arab kepada Tuhan yang sebenarnya, yang berhak disembah, yang mempunyai sifat-sifat kesempurnaan. Mereka tidak memakai kata itu untuk tuhan-tuhan atau dewa-dewa mereka yang lain.

Hikmah Membaca Basmalah

Seorang yang selalu membaca Basmalah sebelum melakukan pekerjaan yang penting, berarti ia selalu mengingat Allah pada setiap pekerjaannya. Dengan demikian ia akan melakukan pekerjaan tersebut dengan selalu memperhatikan norma-norma Allah dan tidak merugikan orang lain. Dampaknya, pekerjaan yang dilakukannya akan berbuah sebagai amalan ukhrawi.

Seorang Muslim diperintahkan membaca Basmalah pada waktu mengerjakan sesuatu yang baik. Yang demikian itu untuk mengingatkan bahwa sesuatu yang dikerjakan adalah karena perintah Allah, atau karena telah diizinkan-Nya. Maka karena Allah dia mengerjakan pekerjaan itu dan kepada-Nya dia meminta pertolongan agar pekerjaan terlaksana dengan baik dan berhasil.

Nabi saw bersabda:

"Setiap pekerjaan penting yang tidak dimulai dengan menyebut Basmalah adalah buntung (kurang berkahnya)." (Riwayat Abdul-Qadir ar-Rahawi).

Orang Arab sebelum datang Islam mengerjakan sesuatu dengan menyebut al-Lata dan al-'Uzza, nama-nama berhala mereka. Sebab itu, Allah mengajarkan kepada penganut-penganut agama Islam yang telah mengesakan-Nya, agar mereka mengerjakan sesuatu dengan menyebut nama Allah. ''',
                              style: TextStyle(
                                color: HexColor.fromHex("#7c97a6"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor.fromHex("#132e3a"),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#28ab9e"),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.brightness_5_sharp,
                                    color: HexColor.fromHex(
                                      "#28ab9e",
                                    ).withAlpha(90),
                                    size: 40,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.isExpanded) {
                                        controller.collapse();
                                      } else {
                                        controller.expand();
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: HexColor.fromHex("#1a3a4a"),
                                      ),
                                      child: Icon(
                                        Icons.menu_book_rounded,
                                        color: HexColor.fromHex("#5a7b8a"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: HexColor.fromHex("#1a3a4a"),
                                    ),
                                    child: Icon(
                                      Icons.play_circle_filled_rounded,
                                      color: HexColor.fromHex("#2dc8b9"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Divider(
                                color: HexColor.fromHex(
                                  "#5a7b8a",
                                ).withAlpha(90),
                                thickness: 0.1,
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bismillāhir-raḥmānir-raḥīm(i).",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#228276"),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Dengan nama Allah Yang Maha Pengasih lagi Maha Penyayang.",
                                    style: TextStyle(
                                      color: HexColor.fromHex("#7c97a6"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
