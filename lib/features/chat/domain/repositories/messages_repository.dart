import 'package:convo_sphere/features/chat/domain/entities/daily_question_entity.dart';
import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';

abstract class MessagesRepository {
  Future<List<MessageEntity>> fetchMessages(String conversationId);

  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId);

  Future<void> sendMessage(MessageEntity message);
}
