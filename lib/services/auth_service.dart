import '../services/api.dart';

class AuthService {
  Api api = new Api();

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response = await api.postAsync('auth/login', body);
    return response;
  }
}
