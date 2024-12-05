import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String _baseUrl = 'http://192.168.20.233:6000/auth';

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body)['user']);
      } else {
        return null;
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');

      return null;
    }
  }

  Future<UserModel?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');

      return null;
    }
  }
}
