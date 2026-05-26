class event {
  final String eventID;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String description;
  final int entranceFee;
  final String startTime;
  final String endTime;
  final String socialMedia;
  final String imagePath;
  final String destinationID;
  final String adminID;
  final DateTime? deletedAt;

  const event({
    required this.eventID,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
    required this.entranceFee,
    required this.startTime,
    required this.endTime,
    required this.socialMedia,
    required this.imagePath,
    required this.destinationID,
    required this.adminID,
    this.deletedAt,
  });

  factory event.fromJson(Map<String, dynamic> json) {
    return event(
      eventID: json['eventID']?.toString() ?? '',
      name: json['name'] ?? '',
      startDate:
          DateTime.tryParse(json['startDate']?.toString() ?? '') ??
          DateTime.now(),
      endDate:
          DateTime.tryParse(json['endDate']?.toString() ?? '') ??
          DateTime.now(),
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      entranceFee: json['entranceFee'] is int
          ? json['entranceFee']
          : int.tryParse(json['entranceFee']?.toString() ?? '0') ?? 0,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      socialMedia: json['socialMedia'] ?? '',
      imagePath: json['imagePath'] ?? '',
      destinationID: json['destinationID']?.toString() ?? '',
      adminID: json['adminID']?.toString() ?? '',
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
    );
  }
}
