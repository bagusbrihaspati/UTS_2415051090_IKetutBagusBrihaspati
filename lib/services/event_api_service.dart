import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/campus_event.dart';

class EventApiService {
  // Mock endpoint publik untuk katalog kegiatan
  static const String _baseUrl =
      'https://my-json-server.typicode.com/bagusbrihaspati/mock-campus-events/events';

  Future<List<CampusEvent>> fetchEvents() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CampusEvent.fromJson(json)).toList();
      } else {
        return _getFallbackEvents();
      }
    } catch (_) {
      // Fallback data lokal yang valid jika offline atau endpoint belum deploy
      return _getFallbackEvents();
    }
  }

  List<CampusEvent> _getFallbackEvents() {
    return [
      CampusEvent(
        id: 'EVT101',
        title: 'Seminar Nasional Riset & Inovasi Teknologi (SENARI)',
        category: 'Seminar',
        organizer: 'LPPM Undiksha',
        date: '2026-11-25',
        location: 'Auditorium Undiksha & Zoom',
        description:
            'Seminar diseminasi hasil penelitian dosen dan mahasiswa bidang komputasi, robotika, dan teknologi cerdas.',
        imageUrl:
            'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600',
      ),
      CampusEvent(
        id: 'EVT102',
        title: 'Workshop Flutter Multiplatform & Clean Architecture',
        category: 'Workshop',
        organizer: 'HMJ Teknik Informatika FTK',
        date: '2026-12-02',
        location: 'Lab Komputer FTK Undiksha',
        description:
            'Pelatihan praktis arsitektur aplikasi mobile terkini, state management Provider, dan backend PostgreSQL.',
        imageUrl:
            'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=600',
      ),
      CampusEvent(
        id: 'EVT103',
        title: 'Informatics Festival & Competitive Programming',
        category: 'Lomba',
        organizer: 'BEM FTK Undiksha',
        date: '2026-12-10',
        location: 'Kampus Tengah Undiksha',
        description:
            'Kompetisi algoritma pemecahan masalah dan pameran proyek inovasi multimedia karya mahasiswa PTI.',
        imageUrl:
            'https://images.unsplash.com/photo-1511578314322-379afb476865?w=600',
      ),
      CampusEvent(
        id: 'EVT104',
        title: 'Malam Gelar Seni & Budaya Nusantara',
        category: 'Festival',
        organizer: 'Dewan Mahasiswa Undiksha',
        date: '2026-12-18',
        location: 'Gedung Kesenian Gde Manik Singaraja',
        description:
            'Pagelaran tari tradisi kolaborasi modern, instalasi visual 2D multimedia, dan pertunjukan musik ormada.',
        imageUrl:
            'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600',
      ),
    ];
  }
}
