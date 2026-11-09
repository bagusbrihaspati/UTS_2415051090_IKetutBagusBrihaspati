import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/registered_event.dart';

class EventDatabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // READ: Mengambil seluruh agenda dari tabel registered_events
  Future<List<RegisteredEvent>> getRegisteredEvents() async {
    final response = await _client
        .from('registered_events')
        .select()
        .order('id', ascending: false);

    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => RegisteredEvent.fromJson(json)).toList();
  }

  Future<RegisteredEvent> insertEvent(RegisteredEvent event) async {
    final response = await _client
        .from('registered_events')
        .insert(event.toJson())
        .select()
        .single();

    return RegisteredEvent.fromJson(response);
  }
}