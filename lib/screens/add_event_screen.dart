import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/campus_event.dart';
import '../models/registered_event.dart';
import '../providers/event_provider.dart';

class AddEventScreen extends StatefulWidget {
  final CampusEvent? initialEvent;

  const AddEventScreen({super.key, this.initialEvent});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _notesController;

  String _selectedRole = 'Peserta';
  String _selectedStatus = 'planned';
  bool _isSubmitting = false;

  final _roles = [
    'Peserta',
    'Panitia',
    'Koordinator',
    'Pengisi Acara',
  ];

  final _statusOptions = [
    {'value': 'planned', 'label': 'Rencana'},
    {'value': 'active', 'label': 'Sedang Berjalan'},
    {'value': 'completed', 'label': 'Selesai'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.initialEvent?.title ?? '');
    _dateController = TextEditingController(
      text: widget.initialEvent?.date ??
          DateTime.now().toString().split(' ')[0],
    );
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final newEvent = RegisteredEvent(
      eventId: widget.initialEvent?.id ??
          'CUSTOM_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      role: _selectedRole,
      eventDate: _dateController.text.trim(),
      notes: _notesController.text.trim(),
      status: _selectedStatus,
    );

    final provider = Provider.of<EventProvider>(context, listen: false);
    final success = await provider.addEventToSchedule(newEvent);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kegiatan berhasil ditambahkan ke agenda pribadi!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.scheduleError ?? 'Gagal menyimpan data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah ke Agenda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kegiatan *',
                  hintText: 'Contoh: Workshop Mobile Programming',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nama kegiatan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Peran / Divisi *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                items: _roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRole = val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Pelaksanaan (YYYY-MM-DD) *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Tanggal wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status Pelaksanaan *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: _statusOptions.map((opt) {
                  return DropdownMenuItem<String>(
                    value: opt['value'],
                    child: Text(opt['label']!),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedStatus = val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan Tugas / Persiapan Pribadi',
                  hintText: 'Misal: Membawa laptop, menyiapkan berkas acara...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note_alt),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submitForm,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    _isSubmitting ? 'Menyimpan...' : 'Simpan Kegiatan',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}