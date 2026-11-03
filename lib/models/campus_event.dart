class CampusEvent {
  final String id;
  final String title;
  final String category; // Seminar, Workshop, Lomba, Festival
  final String organizer;
  final String date;
  final String location;
  final String description;
  final String imageUrl;

  CampusEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.organizer,
    required this.date,
    required this.location,
    required this.description,
    required this.imageUrl,
  });

  factory CampusEvent.fromJson(Map<String, dynamic> json) {
    return CampusEvent(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? 'Umum',
      organizer: json['organizer'] ?? 'Undiksha',
      date: json['date'] ?? '',
      location: json['location'] ?? 'Kampus Undiksha',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? 'https://picsum.photos/400/250',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'organizer': organizer,
      'date': date,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
