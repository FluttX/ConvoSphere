import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String _baseUrl = 'http://192.168.20.219:6000/api';
  final _storage = const FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.get(
        Uri.parse('$_baseUrl/conversations'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => ConversationModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch conversations');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to fetch conversations');
    }
  }
}
