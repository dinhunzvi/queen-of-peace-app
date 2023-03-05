import 'package:flutter/cupertino.dart';
import 'package:queen_of_peace/providers/auth_provider.dart';
import 'package:queen_of_peace/services/api.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];

  late ApiService apiService;

  late AuthProvider authProvider;

  UserProvider(this.authProvider) {
    apiService = ApiService(authProvider.token);

    init();
  }

  Future<void> init() async {
    users = await apiService.fetchUsers();

    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    User updatedUser = await apiService.updateUser(user);
    int index = users.indexOf(updatedUser);
    users[index] = updatedUser;

    notifyListeners();
  }
}
