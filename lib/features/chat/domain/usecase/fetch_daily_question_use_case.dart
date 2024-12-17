import 'package:convo_sphere/features/chat/domain/entities/daily_question_entity.dart';
import 'package:convo_sphere/features/chat/domain/repositories/messages_repository.dart';

class FetchDailyQuestionUseCase {
  FetchDailyQuestionUseCase({required this.repository});

  final MessagesRepository repository;

  Future<DailyQuestionEntity> call(String conversationId) async {
    return await repository.fetchDailyQuestion(conversationId);
  }
}
