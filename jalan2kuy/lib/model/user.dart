class User {
  final String userID;
  final String nameUser;
  final String email;
  final String phone;
  final bool gender;
  final DateTime birthDate;
  final String username;
  final String password;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    required this.userID,
    required this.nameUser,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.username,
    required this.password,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID']?.toString() ?? '',
      nameUser: json['nameUser'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender:
          json['gender'] == 1 ||
          json['gender'] == '1' ||
          json['gender'] == true,
      birthDate:
          DateTime.tryParse(json['birthDate']?.toString() ?? '') ??
          DateTime.now(),
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
