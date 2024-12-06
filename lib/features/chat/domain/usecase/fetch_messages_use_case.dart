import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';
import 'package:convo_sphere/features/chat/domain/repositories/messages_repository.dart';

class FetchMessagesUseCase {
  FetchMessagesUseCase({required this.repository});

  final MessagesRepository repository;

  Future<List<MessageEntity>> call(String conversationId) async {
    return await repository.fetchMessages(conversationId);
  }
}
