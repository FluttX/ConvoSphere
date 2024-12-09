import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/core/app_constants.dart';
import 'package:convo_sphere/features/contacts/data/models/contact_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContactsRemoteDataSource {
  final String _baseUrl = '${AppConstants.baseUrl}/api';
  final _storage = const FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts() async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.get(
        Uri.parse('$_baseUrl/contacts/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => ContactModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch contacts');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to fetch contacts');
    }
  }

  Future<String> addContact(String email) async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.post(
        Uri.parse('$_baseUrl/contacts/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch contacts');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to fetch contacts');
    }
  }
}
