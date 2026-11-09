import 'package:flutter/material.dart';
import '../models/campus_event.dart';
import '../models/registered_event.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  // State Katalog Kegiatan Publik (REST API)
  List<CampusEvent> _catalogEvents = [];
  bool _isCatalogLoading = false;
  String? _catalogError;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  // State Agenda Pribadi (Supabase Database)
  List<RegisteredEvent> _myScheduleEvents = [];
  bool _isScheduleLoading = false;
  String? _scheduleError;

  // Getters
  List<CampusEvent> get catalogEvents => _catalogEvents;
  bool get isCatalogLoading => _isCatalogLoading;
  String? get catalogError => _catalogError;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<RegisteredEvent> get myScheduleEvents => _myScheduleEvents;
  bool get isScheduleLoading => _isScheduleLoading;
  String? get scheduleError => _scheduleError;

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

  // REST API Fetcher
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

  // Supabase READ
  Future<void> fetchMySchedule() async {
    _isScheduleLoading = true;
    _scheduleError = null;
    notifyListeners();

    try {
      final data = await _eventRepository.getRegisteredEvents();
      _myScheduleEvents = data;
      _scheduleError = null;
    } catch (e) {
      _scheduleError = 'Gagal memuat agenda: $e';
    } finally {
      _isScheduleLoading = false;
      notifyListeners();
    }
  }

  // Supabase CREATE
  Future<bool> addEventToSchedule(RegisteredEvent event) async {
    _isScheduleLoading = true;
    _scheduleError = null;
    notifyListeners();

    try {
      final newEvent = await _eventRepository.addRegisteredEvent(event);
      _myScheduleEvents.insert(0, newEvent);
      return true;
    } catch (e) {
      _scheduleError = 'Gagal menyimpan: $e';
      return false;
    } finally {
      _isScheduleLoading = false;
      notifyListeners();
    }
  }

  // Supabase UPDATE (Milestone 11)
  Future<bool> updateScheduleEvent(RegisteredEvent updated) async {
    _isScheduleLoading = true;
    _scheduleError = null;
    notifyListeners();

    try {
      final result = await _eventRepository.updateRegisteredEvent(updated);
      final index = _myScheduleEvents.indexWhere((e) => e.id == result.id);
      if (index != -1) {
        _myScheduleEvents[index] = result;
      }
      return true;
    } catch (e) {
      _scheduleError = 'Gagal memperbarui: $e';
      return false;
    } finally {
      _isScheduleLoading = false;
      notifyListeners();
    }
  }

  // Supabase DELETE (Milestone 12)
  Future<bool> deleteScheduleEvent(int id) async {
    _isScheduleLoading = true;
    _scheduleError = null;
    notifyListeners();

    try {
      await _eventRepository.deleteRegisteredEvent(id);
      _myScheduleEvents.removeWhere((e) => e.id == id);
      return true;
    } catch (e) {
      _scheduleError = 'Gagal menghapus: $e';
      return false;
    } finally {
      _isScheduleLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}