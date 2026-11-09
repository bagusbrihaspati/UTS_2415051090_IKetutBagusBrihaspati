import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/registered_event.dart';

class EventDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // READ: Mengambil seluruh agenda dari Supabase
  Future<List<RegisteredEvent>> getRegisteredEvents() async {
    final response = await _client
        .from('registered_events')
        .select()
        .order('id', ascending: false);

    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => RegisteredEvent.fromJson(json)).toList();
  }

  // CREATE: Menambahkan pendaftaran kegiatan baru
  Future<RegisteredEvent> insertEvent(RegisteredEvent event) async {
    final response = await _client
        .from('registered_events')
        .insert(event.toJson())
        .select()
        .single();

    return RegisteredEvent.fromJson(response);
  }

  // UPDATE: Memperbarui data kegiatan (catatan, status, peran, tanggal)
  Future<RegisteredEvent> updateEvent(RegisteredEvent event) async {
    final response = await _client
        .from('registered_events')
        .update(event.toJson())
        .eq('id', event.id!)
        .select()
        .single();

    return RegisteredEvent.fromJson(response);
  }

  // DELETE: Menghapus kegiatan berdasarkan id
  Future<void> deleteEvent(int id) async {
    await _client.from('registered_events').delete().eq('id', id);
  }
}