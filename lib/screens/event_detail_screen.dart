import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/campus_event.dart';
import '../providers/event_provider.dart';
import 'add_event_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final CampusEvent event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventProvider>();
    final isAlreadySaved = provider.myScheduleEvents.any(
      (e) => e.title.toLowerCase() == event.title.toLowerCase(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kegiatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Bagikan',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tautan kegiatan ${event.title} disalin!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster / Header Image
            Image.network(
              event.imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240,
                color: Colors.deepPurple.shade100,
                child: const Center(
                  child: Icon(Icons.event, size: 72, color: Colors.deepPurple),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Kategori & Tanggal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.category,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            event.date,
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Judul Kegiatan
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Penyelenggara & Lokasi
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.account_balance, color: Colors.deepPurple),
                    ),
                    title: const Text('Penyelenggara', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(event.organizer, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.location_on, color: Colors.deepPurple),
                    ),
                    title: const Text('Lokasi Pelaksanaan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(event.location, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 32),

                  // Deskripsi
                  Text(
                    'Tentang Kegiatan',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 32),

                  // Tombol Aksi Tambah ke Agenda
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: isAlreadySaved ? Colors.grey : null,
                      ),
                      onPressed: () {
                        if (isAlreadySaved) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kegiatan ini sudah ada dalam agenda Anda!')),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEventScreen(initialEvent: event),
                            ),
                          );
                        }
                      },
                      icon: Icon(isAlreadySaved ? Icons.check : Icons.bookmark_add),
                      label: Text(
                        isAlreadySaved ? 'Sudah Terdaftar di Agenda' : 'Daftar / Simpan ke Agenda',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}