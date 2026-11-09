import 'package:flutter/material.dart';
import '../models/campus_event.dart';
import '../models/registered_event.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  // 1. State untuk Katalog Kegiatan Publik (REST API)
  List<CampusEvent> _catalogEvents = [];
  bool _isCatalogLoading = false;
  String? _catalogError;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  // 2. State untuk Agenda Pribadi (Supabase Database)
  List<RegisteredEvent> _myScheduleEvents = [];
  bool _isScheduleLoading = false;
  String? _scheduleError;

  // --- Getters ---
  List<CampusEvent> get catalogEvents => _catalogEvents;
  bool get isCatalogLoading => _isCatalogLoading;
  String? get catalogError => _catalogError;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<RegisteredEvent> get myScheduleEvents => _myScheduleEvents;
  bool get isScheduleLoading => _isScheduleLoading;
  String? get scheduleError => _scheduleError;

  // Filter gabungan kategori & pencarian untuk Katalog Event
  List<CampusEvent> get filteredCatalogEvents {
    return _catalogEvents.where((event) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          event.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = event.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          event.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.organizer.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // --- REST API Fetcher (Milestone 8) ---
  Future<void> fetchCatalogFromApi() async {
    _isCatalogLoading = true;
    _catalogError = null;
    notifyListeners();

    try {
      final data = await _eventRepository.getCampusEvents();
      _catalogEvents = data;
      _catalogError = null;
    } catch (e) {
      _catalogError = 'Gagal memuat katalog: $e';
    } finally {
      _isCatalogLoading = false;
      notifyListeners();
    }
  }

  // --- Mutators & Filter Handlers ---
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Setters State Agenda Pribadi (Supabase)
  void setScheduleLoading(bool loading) {
    _isScheduleLoading = loading;
    _scheduleError = null;
    notifyListeners();
  }

  void setScheduleData(List<RegisteredEvent> events) {
    _myScheduleEvents = events;
    _isScheduleLoading = false;
    _scheduleError = null;
    notifyListeners();
  }

  void setScheduleError(String error) {
    _scheduleError = error;
    _isScheduleLoading = false;
    notifyListeners();
  }

  bool isEventRegistered(String eventId) {
    return _myScheduleEvents.any((e) => e.eventId == eventId);
  }
}