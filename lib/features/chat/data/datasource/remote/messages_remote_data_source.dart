import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/core/app_constants.dart';
import 'package:convo_sphere/features/chat/data/models/message_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String _baseUrl = '${AppConstants.baseUrl}/api';
  final _storage = const FlutterSecureStorage();

  Future<List<MessageModel>> fetchMessages(String conversationId) async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.get(
        Uri.parse('$_baseUrl/messages/$conversationId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch messages');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to fetch messages');
    }
  }
}
