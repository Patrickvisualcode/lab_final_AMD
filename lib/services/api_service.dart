import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api/users';

  Future<List<User>> fetchUsers() async {
    final res = await http.get(Uri.parse('$baseUrl?page=1'));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final List list = data['data'];
      return list.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  Future<User> addUser(User u) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(u.toJson()),
    );
    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      return User(
        id: int.tryParse(data['id'] ?? '0') ?? 0,
        name: u.name,
        email: u.email,
      );
    } else {
      throw Exception('Error al agregar usuario');
    }
  }

  Future<void> updateUser(User u) async {
    final res = await http.put(
      Uri.parse('$baseUrl/${u.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(u.toJson()),
    );
    if (res.statusCode != 200) {
      throw Exception('Error al actualizar usuario');
    }
  }

  Future<void> deleteUser(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode != 204) {
      throw Exception('Error al eliminar usuario');
    }
  }
}
