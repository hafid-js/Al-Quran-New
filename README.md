# alquran_new

A new Flutter project.

## Environment / API key

API key **tidak** disimpan di repo. Sebelum menjalankan project:

```bash
cp .env.example .env
```

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

File `.env`, `android/local.properties`, dan
`ios/Flutter/Secrets.xcconfig` sudah masuk `.gitignore`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
