class ApiConfig {
  // Ubah IP ini sesuai dengan jaringan Anda saat ini
  // static const String _baseUrl = 'http://192.168.1.41:8000';
  static const String _baseUrl =
      'https://legal-sitting-womanhood.ngrok-free.dev';

  // Endpoint List
  static const String login = '$_baseUrl/api/';

  static const String account = '$_baseUrl/api/account';
  static const String editAccount = '$_baseUrl/api/account/edit';
  static const String destination = '$_baseUrl/api/destination';
  static const String destinationByCategory = '$_baseUrl/api/destination/category';

  // Anda bisa menambahkan endpoint lain di sini nanti, misal:
  // static const String register = '$_baseUrl/api/register';
  // static const String destinations = '$_baseUrl/api/destinations';

  // URL untuk Gambar (Utuh!)
  static const String storageUrl = '$_baseUrl/storage';
}
