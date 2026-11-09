import '../models/campus_event.dart';
import '../services/event_api_service.dart';

class EventRepository {
  final EventApiService _apiService;

  EventRepository({EventApiService? apiService})
      : _apiService = apiService ?? EventApiService();

  Future<List<CampusEvent>> getCampusEvents() async {
    return await _apiService.fetchEvents();
  }
}