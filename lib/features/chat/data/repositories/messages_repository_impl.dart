import 'package:convo_sphere/features/chat/data/datasource/remote/messages_remote_data_source.dart';
import 'package:convo_sphere/features/chat/domain/entities/daily_question_entity.dart';
import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';
import 'package:convo_sphere/features/chat/domain/repositories/messages_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRepositoryImpl({required this.remoteDataSource});

  final MessagesRemoteDataSource remoteDataSource;

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    return await remoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId) async {
    return await remoteDataSource.fetchDailyQuestion(conversationId);
  }
}
