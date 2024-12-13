import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/core/app_constants.dart';
import 'package:convo_sphere/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String _baseUrl = '${AppConstants.baseUrl}/api';
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

  Future<String> checkOrCreateConversation(String contactId) async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.post(
        Uri.parse('$_baseUrl/conversations/check-or-create'),
        body: jsonEncode({'contactId': contactId}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body != null && body['conversationId'] != null) {
          return body['conversationId'].toString();
        } else {
          throw Exception('Invalid response structure');
        }
      } else {
        throw Exception('Failed to check or create conversation');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to check or create conversation');
    }
  }
}
