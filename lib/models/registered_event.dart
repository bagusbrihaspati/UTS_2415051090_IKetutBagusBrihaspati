class RegisteredEvent {
  final int? id;
  final String eventId;
  final String title;
  final String role; // Peserta, Panitia, Koordinator
  final String eventDate;
  final String notes;
  final String status; // planned, active, completed
  final DateTime? createdAt;

  RegisteredEvent({
    this.id,
    required this.eventId,
    required this.title,
    required this.role,
    required this.eventDate,
    required this.notes,
    required this.status,
    this.createdAt,
  });

  factory RegisteredEvent.fromJson(Map<String, dynamic> json) {
    return RegisteredEvent(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      eventId: json['event_id'] ?? '',
      title: json['title'] ?? '',
      role: json['role'] ?? 'Peserta',
      eventDate: json['event_date'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'planned',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'event_id': eventId,
      'title': title,
      'role': role,
      'event_date': eventDate,
      'notes': notes,
      'status': status,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  RegisteredEvent copyWith({
    int? id,
    String? eventId,
    String? title,
    String? role,
    String? eventDate,
    String? notes,
    String? status,
    DateTime? createdAt,
  }) {
    return RegisteredEvent(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      role: role ?? this.role,
      eventDate: eventDate ?? this.eventDate,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
