import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService api = ApiService();
  List<User> users = [];
  bool loading = false;

  Future<void> loadUsers() async {
    loading = true;
    notifyListeners();
    users = await api.fetchUsers();
    loading = false;
    notifyListeners();
  }

  Future<void> addUser(User u) async {
    final newU = await api.addUser(u);
    users.add(newU);
    notifyListeners();
  }

  Future<void> editUser(User u) async {
    await api.updateUser(u);
    int idx = users.indexWhere((e) => e.id == u.id);
    if (idx >= 0) {
      users[idx] = u;
      notifyListeners();
    }
  }

  Future<void> removeUser(int id) async {
    await api.deleteUser(id);
    users.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
