import '../models/campus_event.dart';
import '../models/registered_event.dart';
import '../services/event_api_service.dart';
import '../services/event_database_service.dart';

class EventRepository {
  final EventApiService _apiService;
  final EventDatabaseService _dbService;

  EventRepository({
    EventApiService? apiService,
    EventDatabaseService? dbService,
  })  : _apiService = apiService ?? EventApiService(),
        _dbService = dbService ?? EventDatabaseService();

  // REST API
  Future<List<CampusEvent>> getCampusEvents() async {
    return await _apiService.fetchEvents();
  }

  // Supabase Database CRUD
  Future<List<RegisteredEvent>> getRegisteredEvents() async =>
      await _dbService.getRegisteredEvents();

  Future<RegisteredEvent> addRegisteredEvent(RegisteredEvent event) async =>
      await _dbService.insertEvent(event);

  Future<RegisteredEvent> updateRegisteredEvent(RegisteredEvent event) async =>
      await _dbService.updateEvent(event);

  Future<void> deleteRegisteredEvent(int id) async =>
      await _dbService.deleteEvent(id);
}