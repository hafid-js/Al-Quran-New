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


<img width="1677" height="706" alt="Screenshot 2026-11-03 at 7 12 14 AM" src="https://github.com/user-attachments/assets/491a8f99-86a3-4f36-b6ec-02eb69b11b11" />


