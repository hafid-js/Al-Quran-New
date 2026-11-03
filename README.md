# alquran_new

A new Flutter project.

## Environment / API key

API key **tidak** disimpan di repo. Sebelum menjalankan project:

```bash
cp .env.example .env
```

Buat API Key terlebih dahulu di Google Cloud dan gunakan 3 API ini :
<img width="1677" height="706" alt="Screenshot 2026-11-03 at 7 12 14 AM" src="https://github.com/user-attachments/assets/dba796ee-353b-4398-a931-d9f6558e104e" />


Lalu isi `GOOGLE_MAPS_API_KEY` di file `.env`.

> `.env` didaftarkan sebagai asset di `pubspec.yaml`, jadi **wajib ada**
> sebelum menjalankan/build project. Tanpa file tersebut, build akan gagal
> dengan pesan `No file or variants found for asset: .env`.

Untuk build Android, key juga dibaca dari `android/local.properties`:

```properties
GOOGLE_MAPS_API_KEY=xxx
```

Untuk iOS, salin `ios/Flutter/Secrets.xcconfig.example` menjadi
`ios/Flutter/Secrets.xcconfig` dan isi key-nya.

diterminal jalankan :

flutter pub get

flutter run


<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 00 45" src="https://github.com/user-attachments/assets/a8b1a39b-6b6d-4233-a5b8-3a989b1df576" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 00 55" src="https://github.com/user-attachments/assets/3173496c-d990-4ae4-be7f-7bf5109d1656" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 01 21" src="https://github.com/user-attachments/assets/4a496726-5ac6-4ee9-bced-13b24b8e365a" />


<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 02 15" src="https://github.com/user-attachments/assets/264c3b6a-6fc5-4acb-9f66-7fbc617cf048" />


<img width="1170" height="2532" alt="IMG_5379" src="https://github.com/user-attachments/assets/967e612a-16e8-48a7-8292-5f67abf6686f" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 21 37" src="https://github.com/user-attachments/assets/6ea12a81-821c-4d56-b1ce-0711bc27cee9" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 21 53" src="https://github.com/user-attachments/assets/90daed7f-a63a-4bf7-94ce-e9d2416ccb50" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 07" src="https://github.com/user-attachments/assets/88ee7dba-4121-44f2-a24c-e77a9bb24c84" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 10" src="https://github.com/user-attachments/assets/86d397a4-0ceb-448d-bfbe-f37dc85b5e1c" />


<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 19" src="https://github.com/user-attachments/assets/51e82718-fdd3-4a2f-830b-f8d8cef4b420" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 30" src="https://github.com/user-attachments/assets/62e378b2-7842-40f3-9ab8-900e5deeee97" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 48" src="https://github.com/user-attachments/assets/cae8db30-7865-4c85-8a42-429e259be091" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 22 59" src="https://github.com/user-attachments/assets/4846f762-8cfb-46f7-84c5-04f330f245d3" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 23 07" src="https://github.com/user-attachments/assets/1a7b4a65-7597-42cc-9dbc-0837b83d7d7a" />

<img width="1170" height="2532" alt="Simulator Screenshot - iPhone 13 - 2026-09-02 at 22 32 43" src="https://github.com/user-attachments/assets/319152c1-3ad7-446a-aefc-e26ef450607a" />

<img width="1680" height="1050" alt="Screenshot 2026-11-03 at 7 23 48 AM" src="https://github.com/user-attachments/assets/62ae4d30-d241-4a30-aba7-953e3338f318" />


