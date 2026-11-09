import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/registered_event.dart';
import '../providers/event_provider.dart';
import '../widgets/status_badge.dart';
import '../widgets/state_feedback_widget.dart';
import 'add_event_screen.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({super.key});

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final provider = Provider.of<EventProvider>(context, listen: false);
      if (provider.myScheduleEvents.isEmpty) {
        provider.fetchMySchedule();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda & Catatan Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.fetchMySchedule(),
          ),
        ],
      ),
      body: StateFeedbackWidget(
        isLoading: provider.isScheduleLoading,
        errorMessage: provider.scheduleError,
        emptyMessage: 'Belum ada kegiatan yang didaftarkan.',
        onRetry: () => provider.fetchMySchedule(),
        child: provider.myScheduleEvents.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada kegiatan tersimpan di Supabase.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: provider.myScheduleEvents.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = provider.myScheduleEvents[index];
                  return _RegisteredEventCard(item: item);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Catat Kegiatan'),
      ),
    );
  }
}

class _RegisteredEventCard extends StatelessWidget {
  final RegisteredEvent item;

  const _RegisteredEventCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                StatusBadge(status: item.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    item.role,
                    style: const TextStyle(fontSize: 12),
                  ),
                  avatar: const Icon(Icons.badge, size: 16),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Text(
                  item.eventDate,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            if (item.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.notes,
                  style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}