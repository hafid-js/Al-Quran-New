import 'package:alquran_new/features/dzikir/models/dzikir_item.dart';

final List<DzikirItem> dzikirList = [
  DzikirItem(
    id: 1,
    kategori: 'Dzikir Pagi',
    judul: 'Ayat Kursi',
    arab:
        'اَللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ ەۚ لَا تَأْخُذُهٗ سِنَةٌ وَّلَا نَوْمٌۗ لَهٗ مَا فِى السَّمٰوٰتِ وَمَا فِى الْاَرْضِۗ مَنْ ذَا الَّذِيْ يَشْفَعُ عِنْدَهٗٓ اِلَّا بِاِذْنِهٖۗ يَعْلَمُ مَا بَيْنَ اَيْدِيْهِمْ وَمَا خَلْفَهُمْۚ وَلَا يُحِيْطُوْنَ بِشَيْءٍ مِّنْ عِلْمِهٖٓ اِلَّا بِمَا شَاۤءَۚ وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْاَرْضَۚ وَلَا يَـُٔوْدُهٗ حِفْظُهُمَاۚ وَهُوَ الْعَلِيُّ الْعَظِيْمُ',
    latin:
        "Allāhu lā ilāha illā huwal-ḥayyul-qayyūm(u), lā ta'khużuhū sinatuw wa lā naum(un), lahū mā fis-samāwāti wa mā fil-arḍ(i), man żal-lażī yasyfa'u 'indahū illā bi'iżnih(ī), ya'lamu mā baina aidīhim wa mā khalfahum, wa lā yuḥīṭūna bi syai'im min 'ilmihī illā bimā syā'(a), wasi'a kursiyyuhus-samāwāti wal-arḍ(a), wa lā ya'ūduhū ḥifẓuhumā, wa huwal-'aliyyul-'aẓīm(u)",
    arti: 'Allah, tidak ada Tuhan selain Dia, Yang Maha Hidup, Yang terus menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan di bumi. Tidak ada yang dapat memberi syafaat di sisi-Nya tanpa izin-Nya. Dia mengetahui apa yang di hadapan mereka dan di belakang mereka, dan mereka tidak mengetahui sesuatu apa pun tentang ilmu-Nya melainkan apa yang Dia kehendaki. Kursi-Nya meliputi langit dan bumi. Dan Dia tidak merasa berat memelihara keduanya, dan Dia Maha Tinggi, Maha Besar.',
    penjelasan: "test ini untuk penjelasan",
    sumber: 'QS. Al-Baqarah: 255',
    jumlah: 1,
  ),
  DzikirItem(
    id: 2,
    kategori: 'Dzikir Pagi',
    judul: 'Surat Al-Ikhlas',
    arab:
        'قُلْ هُوَ اللّٰهُ اَحَدٌۚ . اَللّٰهُ الصَّمَدُۚ . لَمْ يَلِدْ وَلَمْ يُوْلَدْۙ . وَلَمْ يَكُنْ لَّهٗ كُفُوًا اَحَدٌ',
    latin:
        "Qul huwallāhu aḥad(un). Allāhuṣ-ṣamad(u). Lam yalid wa lam yūlad. Wa lam yakul lahū kufuwan aḥad(un).",
    arti: 'Katakanlah: Dialah Allah, Yang Maha Esa. Allah adalah Tuhan yang bergantung kepada-Nya segala sesuatu. Dia tidak beranak dan tidak diperanakkan. Dan tidak ada seorang pun yang setara dengan Dia.',
    penjelasan: "test ini untuk penjelasan",
    sumber: 'QS. Al-Ikhlas: 1-4',
    jumlah: 3,
  ),
  DzikirItem(
    id: 3,
    kategori: 'Dzikir Pagi',
    judul: 'Surat Al-Falaq',
    arab:
        'قُلْ اَعُوْذُ بِرَبِّ الْفَلَقِۙ . مِنْ شَرِّ مَا خَلَقَۙ . وَمِنْ شَرِّ غَاسِقٍ اِذَا وَقَبَۙ . وَمِنْ شَرِّ النَّفّٰثٰتِ فِى الْعُقَدِۙ . وَمِنْ شَرِّ حَاسِدٍ اِذَا حَسَدَ',
    latin:
        "Qul a'ūżu birabbil-falaq(i). Min syarri mā khalaq(a). Wa min syarri gāsiqin iżā waqab(a). Wa min syarrin-naffāṡāti fil-'uqad(i). Wa min syarri ḥāsidin iżā ḥasad(a).",
    arti: 'Katakanlah: Aku berlindung kepada Tuhan yang menguasai subuh (fajar). Dari kejahatan makhluk-Nya. Dan dari kejahatan malam apabila telah gelap gulita. Dan dari kejahatan wanita-wanita penyihir yang meniup pada buhul-buhul (talinya). Dan dari kejahatan orang yang dengki apabila ia dengki.',
        penjelasan: "test ini untuk penjelasan",
    sumber: 'QS. Al-Falaq: 1-5',
    jumlah: 3,
  ),
  DzikirItem(
    id: 4,
    kategori: 'Dzikir Pagi',
    judul: 'Surat An-Nas',
    arab:
        'قُلْ اَعُوْذُ بِرَبِّ النَّاسِۙ . مَلِكِ النَّاسِۙ . اِلٰهِ النَّاسِۙ . مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِۙ . الَّذِيْ يُوَسْوِسُ فِيْ صُدُوْرِ النَّاسِۙ . مِنَ الْجِنَّةِ وَالنَّاسِ',
    latin:
        "Qul a'ūżu birabbin-nās(i). Malikin-nās(i). Ilāhin-nās(i). Min syarril-waswāsil-khannās(i). Allażī yuwaswisu fī ṣudūrin-nās(i). Minal-jinnati wan-nās(i).",
    arti: 'Katakanlah: Aku berlindung kepada Tuhan (yang memelihara dan menguasai) manusia. Raja manusia. Sembahan manusia. Dari kejahatan (bisikan) setan yang biasa bersembunyi. Yang membisikkan (kejahatan) ke dalam dada manusia. Dari (golongan) jin dan manusia.',
        penjelasan: "test ini untuk penjelasan",
    sumber: 'QS. An-Nas: 1-6',
    jumlah: 3,
  ),
  DzikirItem(
    id: 5,
    kategori: 'Dzikir Pagi',
    judul: 'Subhanallah wa bihamdihi',
    arab:
        'سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ',
    latin:
        "Subḥānallāhi wa biḥamdihī",
    arti: 'Maha Suci Allah dan dengan memuji-Nya.',
        penjelasan: "test ini untuk penjelasan",
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 100,
  ),
  DzikirItem(
    id: 6,
    kategori: 'Dzikir Pagi',
    judul: 'Doa Perlindungan Pagi',
    arab:
        'اَللّٰهُمَّ بِكَ اَصْبَحْنَا وَبِكَ اَمْسَيْنَا، وَبِكَ نَحْيَا وَبِكَ نَمُوْتُ وَاِلَيْكَ النُّشُوْرُ',
    latin:
        "Allāhumma bika aṣbaḥnā wa bika amsainā, wa bika naḥyā wa bika namūtu wa ilaikan-nusyūr(u).",
    arti: 'Ya Allah, dengan-Mu kami memasuki waktu pagi, dengan-Mu kami memasuki waktu petang, dengan-Mu kami hidup, dengan-Mu kami mati, dan kepada-Mu kami dibangkitkan.',
        penjelasan: "test ini untuk penjelasan",
    sumber: 'HR. Abu Dawud, Tirmidzi, Ibnu Majah',
    jumlah: 1,
  ),
  DzikirItem(
    id: 7,
    kategori: 'Dzikir Petang',
    judul: 'Ayat Kursi',
    arab:
        'اَللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ ەۚ لَا تَأْخُذُهٗ سِنَةٌ وَّلَا نَوْمٌۗ لَهٗ مَا فِى السَّمٰوٰتِ وَمَا فِى الْاَرْضِۗ مَنْ ذَا الَّذِيْ يَشْفَعُ عِنْدَهٗٓ اِلَّا بِاِذْنِهٖۗ يَعْلَمُ مَا بَيْنَ اَيْدِيْهِمْ وَمَا خَلْفَهُمْۚ وَلَا يُحِيْطُوْنَ بِشَيْءٍ مِّنْ عِلْمِهٖٓ اِلَّا بِمَا شَاۤءَۚ وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْاَرْضَۚ وَلَا يَـُٔوْدُهٗ حِفْظُهُمَاۚ وَهُوَ الْعَلِيُّ الْعَظِيْمُ',
    latin:
        "Allāhu lā ilāha illā huwal-ḥayyul-qayyūm(u), lā ta'khużuhū sinatuw wa lā naum(un), lahū mā fis-samāwāti wa mā fil-arḍ(i), man żal-lażī yasyfa'u 'indahū illā bi'iżnih(ī), ya'lamu mā baina aidīhim wa mā khalfahum, wa lā yuḥīṭūna bi syai'im min 'ilmihī illā bimā syā'(a), wasi'a kursiyyuhus-samāwāti wal-arḍ(a), wa lā ya'ūduhū ḥifẓuhumā, wa huwal-'aliyyul-'aẓīm(u)",
    arti: 'Allah, tidak ada Tuhan selain Dia, Yang Maha Hidup, Yang terus menerus mengurus (makhluk-Nya), tidak mengantuk dan tidak tidur...',
    sumber: 'QS. Al-Baqarah: 255',
    jumlah: 1,
  ),
  DzikirItem(
    id: 8,
    kategori: 'Dzikir Petang',
    judul: 'Surat Al-Ikhlas, Al-Falaq, An-Nas',
    arab:
        'قُلْ هُوَ اللّٰهُ اَحَدٌۚ . اَللّٰهُ الصَّمَدُۚ . لَمْ يَلِدْ وَلَمْ يُوْلَدْۙ . وَلَمْ يَكُنْ لَّهٗ كُفُوًا اَحَدٌ . قُلْ اَعُوْذُ بِرَبِّ الْفَلَقِۙ . مِنْ شَرِّ مَا خَلَقَۙ ...',
    latin:
        "Qul huwallāhu aḥad... Qul a'ūżu birabbil-falaq... Qul a'ūżu birabbin-nās...",
    arti: 'Katakanlah: Dialah Allah, Yang Maha Esa... Katakanlah: Aku berlindung kepada Tuhan yang menguasai subuh... Katakanlah: Aku berlindung kepada Tuhan (yang memelihara dan menguasai) manusia...',
    sumber: 'QS. Al-Ikhlas, Al-Falaq, An-Nas',
    jumlah: 3,
  ),
  DzikirItem(
    id: 9,
    kategori: 'Dzikir Petang',
    judul: 'Hasbiyallah',
    arab:
        'حَسْبِيَ اللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ ەۚ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
    latin:
        "Ḥasbiyallāhu lā ilāha illā huw(a), 'alaihi tawakkaltu wa huwa rabbul-'arsyil-'aẓīm(i).",
    arti: 'Cukuplah Allah bagiku, tidak ada Tuhan selain Dia. Hanya kepada-Nya aku bertawakkal dan Dia adalah Tuhan yang memiliki Arsy yang agung.',
    sumber: 'QS. At-Taubah: 129',
    jumlah: 7,
  ),
  DzikirItem(
    id: 10,
    kategori: 'Dzikir Petang',
    judul: 'Doa Perlindungan Petang',
    arab:
        'اَللّٰهُمَّ بِكَ اَمْسَيْنَا وَبِكَ اَصْبَحْنَا، وَبِكَ نَحْيَا وَبِكَ نَمُوْتُ وَاِلَيْكَ الْمَصِيْرُ',
    latin:
        "Allāhumma bika amsainā wa bika aṣbaḥnā, wa bika naḥyā wa bika namūtu wa ilaikal-maṣīr(u).",
    arti: 'Ya Allah, dengan-Mu kami memasuki waktu petang, dengan-Mu kami memasuki waktu pagi, dengan-Mu kami hidup, dengan-Mu kami mati, dan kepada-Mu tempat kembali.',
    sumber: 'HR. Abu Dawud, Tirmidzi, Ibnu Majah',
    jumlah: 1,
  ),
  DzikirItem(
    id: 11,
    kategori: 'Dzikir Petang',
    judul: "A'udzu bikalimatillah",
    arab:
        'أَعُوذُ بِكَلِمَاتِ اللّٰهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    latin:
        "A'ūżu bikalimātillāhit-tāmmāti min syarri mā khalaq(a).",
    arti: 'Aku berlindung dengan kalimat-kalimat Allah yang sempurna dari kejahatan makhluk-Nya.',
    sumber: 'HR. Muslim',
    jumlah: 3,
  ),
  DzikirItem(
    id: 12,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Istighfar',
    arab:
        'أَسْتَغْفِرُ اللّٰهَ الْعَظِيْمَ',
    latin:
        "Astaghfirullāhal-'aẓīm(a).",
    arti: 'Aku memohon ampun kepada Allah Yang Maha Agung.',
    sumber: 'HR. Muslim',
    jumlah: 3,
  ),
  DzikirItem(
    id: 13,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Subhanallah',
    arab:
        'سُبْحَانَ اللّٰهِ',
    latin:
        "Subḥānallāh(i).",
    arti: 'Maha Suci Allah.',
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 33,
  ),
  DzikirItem(
    id: 14,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Alhamdulillah',
    arab:
        'الْحَمْدُ لِلّٰهِ',
    latin:
        "Al-ḥamdu lillāh(i).",
    arti: 'Segala puji bagi Allah.',
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 33,
  ),
  DzikirItem(
    id: 15,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Allahu Akbar',
    arab:
        'اللّٰهُ أَكْبَرُ',
    latin:
        "Allāhu akbar(u).",
    arti: 'Allah Maha Besar.',
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 33,
  ),
  DzikirItem(
    id: 16,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Tahlil',
    arab:
        'لَا إِلٰهَ إِلَّا اللّٰهُ وَحْدَهُ لَا شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرٌ',
    latin:
        "Lā ilāha illallāhu waḥdahū lā syarīka lah(ū), lahul-mulku wa lahul-ḥamdu wa huwa 'alā kulli syai'in qadīr(un).",
    arti: 'Tidak ada Tuhan selain Allah, Yang Maha Esa, tidak ada sekutu bagi-Nya. Milik-Nya segala kerajaan dan bagi-Nya segala puji, dan Dia Maha Kuasa atas segala sesuatu.',
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 1,
  ),
  DzikirItem(
    id: 17,
    kategori: 'Dzikir Setelah Sholat',
    judul: 'Ayat Kursi',
    arab:
        'اَللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ...',
    latin:
        "Allāhu lā ilāha illā huwal-ḥayyul-qayyūm(u)...",
    arti: 'Allah, tidak ada Tuhan selain Dia, Yang Maha Hidup, Yang terus menerus mengurus (makhluk-Nya)...',
    sumber: 'QS. Al-Baqarah: 255',
    jumlah: 1,
  ),
  DzikirItem(
    id: 18,
    kategori: 'Dzikir Sebelum Tidur',
    judul: 'Ayat Kursi',
    arab:
        'اَللّٰهُ لَآ اِلٰهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ...',
    latin:
        "Allāhu lā ilāha illā huwal-ḥayyul-qayyūm(u)...",
    arti: 'Allah, tidak ada Tuhan selain Dia, Yang Maha Hidup, Yang terus menerus mengurus (makhluk-Nya)...',
    sumber: 'QS. Al-Baqarah: 255',
    jumlah: 1,
  ),
  DzikirItem(
    id: 19,
    kategori: 'Dzikir Sebelum Tidur',
    judul: 'Surat Al-Ikhlas, Al-Falaq, An-Nas',
    arab:
        'قُلْ هُوَ اللّٰهُ اَحَدٌۚ . قُلْ اَعُوْذُ بِرَبِّ الْفَلَقِۙ . قُلْ اَعُوْذُ بِرَبِّ النَّاسِۙ',
    latin:
        "Qul huwallāhu aḥad... Qul a'ūżu birabbil-falaq... Qul a'ūżu birabbin-nās...",
    arti: 'Katakanlah: Dialah Allah, Yang Maha Esa... Katakanlah: Aku berlindung kepada Tuhan yang menguasai subuh... Katakanlah: Aku berlindung kepada Tuhan (yang memelihara dan menguasai) manusia...',
    sumber: 'QS. Al-Ikhlas, Al-Falaq, An-Nas',
    jumlah: 1,
  ),
  DzikirItem(
    id: 20,
    kategori: 'Dzikir Sebelum Tidur',
    judul: 'Tasbih, Tahmid, Takbir',
    arab:
        'سُبْحَانَ اللّٰهِ (٣٣×) . الْحَمْدُ لِلّٰهِ (٣٣×) . اللّٰهُ أَكْبَرُ (٣٣×)',
    latin:
        "Subḥānallāh(i) (33×). Al-ḥamdu lillāh(i) (33×). Allāhu akbar(u) (33×).",
    arti: 'Maha Suci Allah (33×). Segala puji bagi Allah (33×). Allah Maha Besar (33×).',
    sumber: 'HR. Bukhari dan Muslim',
    jumlah: 99,
  ),
  DzikirItem(
    id: 21,
    kategori: 'Dzikir Sebelum Tidur',
    judul: 'Doa Sebelum Tidur',
    arab:
        'بِسْمِكَ اللّٰهُمَّ أَمُوْتُ وَأَحْيَا',
    latin:
        "Bismikallāhumma amūtu wa aḥyā.",
    arti: 'Dengan nama-Mu, ya Allah, aku mati dan aku hidup.',
    sumber: 'HR. Bukhari',
    jumlah: 1,
  ),
  DzikirItem(
    id: 22,
    kategori: 'Dzikir Bangun Tidur',
    judul: 'Doa Bangun Tidur',
    arab:
        'الْحَمْدُ لِلّٰهِ الَّذِيْ أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُوْرُ',
    latin:
        "Al-ḥamdu lillāhillażī aḥyānā ba'da mā amātanā wa ilain-nusyūr(u).",
    arti: 'Segala puji bagi Allah yang telah menghidupkan kami setelah mematikan kami, dan hanya kepada-Nya kami kembali.',
    sumber: 'HR. Bukhari',
    jumlah: 1,
  ),
  DzikirItem(
    id: 23,
    kategori: 'Dzikir Bangun Tidur',
    judul: 'Doa Kesehatan',
    arab:
        'اَلْحَمْدُ لِلّٰهِ الَّذِيْ عَافَانِي فِيْ جَسَدِيْ، وَرَدَّ عَلَيَّ رُوْحِيْ، وَأَذِنَ لِيْ بِذِكْرِهِ',
    latin:
        "Al-ḥamdu lillāhillażī 'āfānī fī jasadī, wa radda 'alayya rūḥī, wa ażina lī biżikrih(ī).",
    arti: 'Segala puji bagi Allah yang telah menyembuhkan tubuhku, mengembalikan ruhku, dan mengizinkanku untuk berdzikir kepada-Nya.',
    sumber: 'HR. Tirmidzi',
    jumlah: 1,
  ),
];
