# 🍲 TugasAplikasi – Aplikasi Resep Masakan Flutter

**TugasAplikasi** adalah aplikasi Flutter yang dirancang untuk membantu pengguna menemukan resep masakan favorit, mengikuti proses memasak, dan mendapatkan inspirasi kuliner dengan UI yang ramah pengguna dan interaktif.

---

## 🚀 Fitur Utama

- 🎯 Onboarding 3-langkah untuk memperkenalkan fitur aplikasi
- 📝 Sign Up & Login sederhana dengan validasi
- 🧾 Pemilihan kategori masakan sesuai preferensi
- 🌀 Animasi loading menggunakan Lottie
- 🔄 Mode terang/gelap dan pengaturan bahasa dengan `Provider`
- 📤 Share dan copy resep via `share_plus` dan `clipboard`
- 📑 SmoothPageIndicator untuk pengalaman paging onboarding yang halus

---

## 📦 Dependensi yang Digunakan (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  smooth_page_indicator: ^1.0.0
  lottie:
  flutter_speed_dial:
  share_plus: ^7.2.1
  clipboard: ^0.1.3
  image_picker:
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  provider:
  flutter_launcher_icons:

flutter_icons:
  android: true
  ios: true
  image_path: "assets/logos/logo.png"
```

### 📁Struktur Folder

```
├── assets/
│   ├── logos/                  # Logo aplikasi
│   ├── onboard/                # Gambar onboarding & Lottie JSON
│   ├── menu/                   # Gambar menu resep
│   ├── ads/                    # (Opsional) untuk banner/iklan
│   └── consultans/             # Gambar untuk fitur konsultasi
lib/
│
├── main.dart                   # Entry point aplikasi
├── Login.dart                  # Halaman login
├── SignUp.dart                 # Halaman sign-up
├── SplashScreen.dart           # Splash screen animasi
├── loadingScreen.dart          # Halaman loading dengan Lottie
├── homePage.dart               # Halaman utama setelah login
├── masakanScreen.dart          # Pilih kategori masakan
├── saranMasakan.dart           # Rekomendasi resep
│
├── provider/
│   ├── provider.dart           # MasakanProvider, SettingsProvider, Consultant
│   └── ChatProvider.dart       # Provider untuk fitur chat/komunikasi
│
```
### Cara Menjalakannya
```
git clone https://github.com/username/tugasaplikasi.git
cd tugasaplikasi

flutter pub get
flutter run
```

