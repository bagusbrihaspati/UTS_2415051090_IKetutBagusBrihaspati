import 'package:flutter/material.dart';
import '../widgets/summary_stat_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToCatalog;
  final VoidCallback onNavigateToSchedule;

  const HomeScreen({
    super.key,
    required this.onNavigateToCatalog,
    required this.onNavigateToSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventHub Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('EventHub v1.0 - PTI Undiksha')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Banner Profil Mahasiswa
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I Ketut Bagus Brihaspati',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text('NIM: 2415051090 | PTI 5A', style: TextStyle(fontSize: 13)),
                        Text('Universitas Pendidikan Ganesha', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Ringkasan Statistik
          const Row(
            children: [
              Expanded(
                child: SummaryStatCard(
                  title: 'Katalog Event',
                  value: 'Loading...',
                  icon: Icons.event,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SummaryStatCard(
                  title: 'Agenda Saya',
                  value: 'Loading...',
                  icon: Icons.assignment_turned_in,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Menu Cepat
          Text(
            'Aksi Cepat',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.explore, color: Colors.deepPurple),
            title: const Text('Jelajahi Katalog Kegiatan'),
            subtitle: const Text('Lihat kegiatan publik & seminar terbaru'),
            trailing: const Icon(Icons.chevron_right),
            onTap: onNavigateToCatalog,
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.calendar_month, color: Colors.teal),
            title: const Text('Kelola Catatan & Agenda Pribadi'),
            subtitle: const Text('Lihat riwayat kepanitiaan dan agenda tersimpan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: onNavigateToSchedule,
          ),
        ],
      ),
    );
  }
}
