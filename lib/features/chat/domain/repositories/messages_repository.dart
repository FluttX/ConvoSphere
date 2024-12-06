import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';

abstract class MessagesRepository {
  Future<List<MessageEntity>> fetchMessages(String conversationId);

  Future<void> sendMessage(MessageEntity message);
}