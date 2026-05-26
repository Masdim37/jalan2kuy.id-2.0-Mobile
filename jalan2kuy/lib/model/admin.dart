class Admin {
  final String adminID;
  final String name;
  final String username;
  final String password;
  final String email;
  final bool gender;

  const Admin({
    required this.adminID,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.gender,
  });

  // 2. Lebih aman menggunakan Map<String, dynamic> standar untuk JSON
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminID: json['AdminID'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      gender:
          json['gender'] == 1 ||
          json['gender'] == '1' ||
          json['gender'] == true,
    );
  }
}
