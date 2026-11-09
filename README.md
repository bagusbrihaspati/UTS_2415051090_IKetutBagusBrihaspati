# EventHub - Campus Activity Manager
Proyek Ujian Tengah Semester (UTS) Pengembangan Aplikasi Mobile  
Program Studi Pendidikan Teknik Informatika (PTI), Fakultas Teknik dan Kejuruan  
Universitas Pendidikan Ganesha (Undiksha) - 2026

---

## 📌 Identitas Mahasiswa
* **Nama**: I Ketut Bagus Brihaspati
* **NIM**: 2415051090
* **Kelas**: PTI 5A
* **Mata Kuliah**: Pemrograman Mobile

---

## 📱 Ringkasan Aplikasi
**EventHub** adalah aplikasi manajemen kegiatan kampus multi-platform yang dibangun menggunakan Flutter, Provider, REST API, dan PostgreSQL Supabase. Aplikasi ini memungkinkan mahasiswa memantau katalog seminar, workshop, festival, dan lomba kampus, serta mengelola catatan dan agenda kepanitiaan personal secara terstruktur.

### Fitur Utama:
1. **Dashboard & Statistik (HomeScreen)**: Ringkasan cepat jumlah agenda publik dan agenda aktif pengguna.
2. **Katalog Kegiatan Publik (CatalogScreen)**: Mengonsumsi data kegiatan kampus dari REST API dengan fitur pencarian teks dan filter chip kategori.
3. **Detail Kegiatan (EventDetailScreen)**: Informasi mendalam tentang acara, lokasi, poster, penyelenggara, dan tombol pendaftaran langsung.
4. **Agenda Saya (MyScheduleScreen)**: Menampilkan riwayat agenda tersimpan dari database Supabase secara real-time.
5. **Form Catat & Tambah Agenda (AddEventScreen)**: Validasi form lengkap untuk mencatat peran (Peserta/Panitia/Koordinator), tanggal, status, dan catatan persiapan.
6. **Edit & Manajemen Status (EditEventScreen)**: Fitur pembaharuan data (Update) dan hapus agenda (Delete) yang disertai dialog konfirmasi modal.
7. **Navigasi Adaptif (Responsive Layout)**: Menggunakan `NavigationBar` untuk perangkat ponsel (<600px) dan beralih otomatis ke `NavigationRail` pada tablet atau layar lebar (≥840px).

---

## 🏗️ Arsitektur & Sumber Data

Aplikasi menerapkan pola **Clean Layered Architecture**:
```text
UI Screens ──> State Management (Provider) ──> Repository Layer ──┬──> REST API Service (HTTP)
                                                                  └──> Database Service (Supabase)

---
*Status: All 6 screens tested, 16 git commits verified, ready for submission.*