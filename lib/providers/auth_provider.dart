import 'package:flutter/cupertino.dart';
import 'package:queen_of_peace/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late String token;
  late ApiService apiService;

  bool isAuthenticated = false;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    token = await getToken();

    if (token.isNotEmpty) {
      isAuthenticated = true;
    }
    apiService = ApiService(token);

    notifyListeners();
  }

  Future<void> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    token = await apiService.register(
        name, email, password, passwordConfirm, deviceName);
    isAuthenticated = true;
    setToken(token);

    notifyListeners();
  }

  Future<void> login(String email, String password, String deviceName) async {
    token = await apiService.login(email, password, deviceName);
    isAuthenticated = true;
    setToken(token);

    notifyListeners();
  }

  Future<void> logout() async {
    token = '';
    isAuthenticated = false;
    setToken(token);

    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  Future<String> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token') ?? '';
  }
}
