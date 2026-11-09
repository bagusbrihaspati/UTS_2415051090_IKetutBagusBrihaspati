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

  // Supabase Database (READ)
  Future<List<RegisteredEvent>> getRegisteredEvents() async {
    return await _dbService.getRegisteredEvents();
  }
}