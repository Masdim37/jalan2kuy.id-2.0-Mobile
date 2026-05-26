class destination {
  final String destinationID;
  final String name;
  final String location;
  final String openingHours;
  final String closingHours;
  final String timezone;
  final String openingDay;
  final String closingDay;
  final int entranceFee;
  final String description;
  final String imagePath;
  final String thumbnailImagePath;
  final String destCategoryID;
  final String adminID;
  final DateTime? deletedAt;

  const destination({
    required this.destinationID,
    required this.name,
    required this.location,
    required this.openingHours,
    required this.closingHours,
    required this.timezone,
    required this.openingDay,
    required this.closingDay,
    required this.entranceFee,
    required this.description,
    required this.imagePath,
    required this.thumbnailImagePath,
    required this.destCategoryID,
    required this.adminID,
    this.deletedAt,
  });

  factory destination.fromJson(Map<String, dynamic> json) {
    return destination(
      destinationID: json['destinationID']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      openingHours: json['openingHours'] ?? '',
      closingHours: json['closingHours'] ?? '',
      timezone: json['timezone'] ?? '',
      openingDay: json['openingDay'] ?? '',
      closingDay: json['closingDay'] ?? '',
      entranceFee: json['entranceFee'] is int
          ? json['entranceFee']
          : int.tryParse(json['entranceFee']?.toString() ?? '0') ?? 0,
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      thumbnailImagePath: json['thumbnailImagePath'] ?? '',
      destCategoryID: json['destCategoryID']?.toString() ?? '',
      adminID: json['adminID']?.toString() ?? '',
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
    );
  }
}
