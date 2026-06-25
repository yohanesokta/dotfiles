# Dotfiles dan Konfigurasi Sistem

Repositori ini berisi berkas konfigurasi (dotfiles) untuk lingkungan desktop Linux berbasis Wayland. Konfigurasi ini dirancang dengan fokus pada efisiensi alur kerja, estetika minimalis, dan integrasi modular antar-komponen.

## Ringkasan Sistem

Sistem ini menggunakan pengatur jendela (window manager) Niri sebagai pusat antarmuka grafis, didukung oleh Kitty sebagai emulator terminal, MPD untuk pemutaran musik, dan skrip pembantu untuk integrasi pengaturan GNOME.

### Komponen Utama

- **Window Manager**: Niri (Scrollable-Tiling Window Manager berbasis Wayland)
- **Status Bar / Shell**: Noctalia Shell (dikelola menggunakan `qs` dan utilitas kontrol IPC `qswrap`)
- **Terminal Emulator**: Kitty (konfigurasi modular dengan dukungan skema warna dinamis)
- **Music Daemon**: MPD (Music Player Daemon) dengan pemrosesan audio melalui PulseAudio
- **Pengatur Berkas**: Nemo dan Dolphin
- **Notifikasi**: SwayNC (Sway Notification Center)
- **Manajemen Wallpaper**: Waypaper serta skrip otomasi Python kustom (`setwall.py`)
- **Keamanan**: Swaylock untuk penguncian layar

---

## Konfigurasi Niri

Niri merupakan pengatur jendela berbasis *tiling* dinamis dengan metode gulir horizontal (*scrollable-tiling*). Konfigurasi Niri pada repositori ini dibagi secara modular ke dalam beberapa berkas `.kdl` untuk mempermudah pemeliharaan:

- `config.kdl`: Berkas utama yang memuat modul-modul konfigurasi lain.
- `startup.kdl`: Mengatur aplikasi yang dijalankan otomatis saat sesi dimulai, termasuk daemon notifikasi (`swaync`), clipboard manager (`cliphist`), dan panel shell (`noctalia-shell`).
- `layout.kdl`: Mengatur dimensi jendela, jarak celah (*gaps*), dan efek visual.
- `window-rules.kdl`: Mengatur aturan perilaku jendela spesifik aplikasi (seperti transparansi, efek buram latar belakang, dan mode mengambang).
- `binds.kdl`: Pemetaan tombol pintas keyboard untuk navigasi dan eksekusi perintah.
- `input.kdl` & `output.kdl`: Konfigurasi perangkat masukan dan resolusi monitor.

### Fitur Visual Niri

Konfigurasi visual Niri disesuaikan untuk menghasilkan tampilan modern yang bersih:

- **Celah Jendela (Gaps)**: Diatur sebesar 10 piksel untuk memberikan ruang pemisah yang konsisten antarjendela.
- **Bingkai Fokus (Focus Ring)**: Menggunakan gradien aktif dari warna sian (`#00ffcc`) ke biru (`#0066ff`) dengan sudut 45 derajat. Warna tidak aktif menggunakan abu-abu gelap (`#505050`).
- **Sudut Melingkar**: Setiap jendela memiliki radius sudut sebesar 10 piksel dengan pemotongan geometri jendela (*clip-to-geometry*) agar sudut terlihat presisi.
- **Efek Bayangan (Shadow)**: Menggunakan bayangan lembut bernilai *softness* 20 dan penyebaran (*spread*) 6 dengan warna putih transparan (`#ffffff55`) untuk memberikan efek pencahayaan di belakang jendela aktif.
- **Transparansi dan Buram Latar Belakang (Blur)**: Efek buram latar belakang diaktifkan untuk aplikasi terminal (Kitty), editor kode (VS Code), dan peramban (Firefox). VS Code diatur dengan nilai opasitas 0.95 untuk mempermudah pembacaan teks sekaligus mempertahankan estetika transparan.

### Navigasi dan Kontrol Utama

Navigasi jendela menggunakan kombinasi tombol modifikator `Super` (Windows) dengan skema navigasi Vim (`H`, `J`, `K`, `L`) atau tombol panah:

- `Super + H` / `Left`: Berpindah fokus ke kolom sebelah kiri.
- `Super + L` / `Right`: Berpindah fokus ke kolom sebelah kanan.
- `Super + J` / `Down` & `Super + K` / `Up`: Berpindah fokus ke jendela dalam satu kolom.
- `Super + Q`: Menutup jendela aktif.
- `Super + O`: Membuka tampilan ringkasan (*overview*).
- `Super + T`: Mengubah status jendela menjadi mengambang (*floating*).
- `Super + Return`: Membuka emulator terminal Kitty.
- `Super + W`: Membuka pengatur wallpaper Waypaper.

Integrasi Noctalia Shell dikendalikan melalui IPC dengan perintah `qswrap`:
- `Ctrl + Shift + Comma`: Membuka panel pengaturan.
- `Super + S`: Membuka panel kontrol (*control center*).
- `Ctrl + Shift + E`: Membuka menu sesi daya (*session menu*).

---

## Konfigurasi Kitty

Emulator terminal Kitty dikonfigurasi secara modular untuk memudahkan penggantian tema visual secara dinamis. Konfigurasi ini mendukung beberapa skema warna populer:

- Tokyo Night (`theme_tokyonight.conf`)
- Catppuccin (`theme_catppuccin.conf`)
- One Dark (`theme_onedark.conf`)
- Rosé Pine (`theme_rose_pine.conf`)

Fitur tambahan pada terminal meliputi:
- Pemosisian jendela terminal di tengah layar secara otomatis.
- Ukuran jendela default yang diatur pada dimensi 140 karakter kolom dan 38 karakter baris.
- Fitur *remote control* yang diaktifkan (`allow_remote_control yes`) untuk mempermudah integrasi skrip eksternal.

---

## Konfigurasi MPD

Music Player Daemon (MPD) diatur sebagai layanan musik lokal dengan spesifikasi berikut:

- Direktori musik dipusatkan pada folder `~/Music`.
- Keluaran audio menggunakan sistem PulseAudio untuk memastikan kompatibilitas dengan manajemen audio sistem.
- Fitur pembaruan pustaka otomatis (`auto_update`) diaktifkan agar lagu baru terdeteksi secara langsung saat ditambahkan ke direktori musik.
- Status pemutaran lagu akan otomatis berada dalam keadaan jeda (`restore_paused`) saat layanan dimulai kembali.

---

## Konfigurasi GNOME

Terdapat skrip pembantu di dalam direktori `GnomeSettings` untuk menyelaraskan pengaturan GNOME Desktop:

- `setting.sh`: Mengonfigurasi tombol pintas keyboard GNOME agar tidak berbenturan dengan konfigurasi pengatur jendela eksternal. Skrip ini menonaktifkan pintasan default seperti peralihan aplikasi menggunakan `Super + 1-9`, pemindahan jendela, serta pemetaan ulang peluncuran pengatur berkas Dolphin menggunakan `Super + E`.
- `reset.sh` & `reset_left_right.sh`: Skrip untuk mengembalikan konfigurasi tombol pintas GNOME ke kondisi standar.
