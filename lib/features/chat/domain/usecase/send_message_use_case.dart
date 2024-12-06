import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';
import 'package:convo_sphere/features/chat/domain/repositories/messages_repository.dart';

class SendMessageUseCase {
  SendMessageUseCase(this.repository);

  final MessagesRepository repository;

  Future<void> call(MessageEntity message) async {
    return await repository.sendMessage(message);
  }
}
