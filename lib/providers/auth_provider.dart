import 'package:flutter/cupertino.dart';
import 'package:queen_of_peace/services/api.dart';

class AuthProvider extends ChangeNotifier {

  late ApiService apiService;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    apiService = ApiService();

    notifyListeners();

  }

}