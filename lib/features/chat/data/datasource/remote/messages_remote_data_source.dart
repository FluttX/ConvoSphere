import 'dart:convert';
import 'dart:developer';

import 'package:convo_sphere/core/constants/app_constants.dart';
import 'package:convo_sphere/features/chat/data/models/daily_question_model.dart';
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

  Future<DailyQuestionModel> fetchDailyQuestion(String conversationId) async {
    try {
      String token = await _storage.read(key: 'token') ?? '';
      final response = await http.get(
        Uri.parse('$_baseUrl/conversations/$conversationId/daily-question'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log(
        '${response.request?.method} - ${response.request?.url} - ${response.statusCode}'
        '\nRESULT: ${response.body}\n\n',
        name: 'API',
      );

      if (response.statusCode == 200) {
        return DailyQuestionModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch question');
      }
    } catch (e) {
      log('- ${e.toString()}', name: 'ERROR');
      throw Exception('Failed to fetch daily question');
    }
  }
}
