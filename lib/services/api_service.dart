import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    final res = await http.get(Uri.parse(baseUrl)); // No need for '?page=1'
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener usuarios: ${res.statusCode}');
    }
  }

  Future<User> addUser(User u) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(u.toJson()),
    );
    if (res.statusCode == 201) { // 201 Created for successful POST
      final Map<String, dynamic> data = jsonDecode(res.body);
      return User.fromJson(data); // Directly parse the returned data
    } else {
      throw Exception('Error al agregar usuario: ${res.statusCode}');
    }
  }

  Future<void> updateUser(User u) async {
    if (u.id == null) {
      throw Exception('No se puede actualizar un usuario sin ID.');
    }
    final res = await http.put(
      Uri.parse('$baseUrl/${u.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(u.toJson()),
    );
    if (res.statusCode != 200) { // 200 OK for successful PUT
      throw Exception('Error al actualizar usuario: ${res.statusCode}');
    }
  }

  Future<void> deleteUser(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    // JSONPlaceholder's DELETE usually returns 200 OK or 204 No Content.
    // We'll check for 200 or 204.
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Error al eliminar usuario: ${res.statusCode}');
    }
  }
}