part of 'messages_bloc.dart';

abstract class MessagesState {}

final class MessagesInitial extends MessagesState {}

class MessageLoadingState extends MessagesState {}

class MessageLoadedState extends MessagesState {
  MessageLoadedState(this.messages);

  final List<MessageEntity> messages;
}

class MessagesErrorState extends MessagesState {
  MessagesErrorState(this.message);

  final String message;
}

class DailyQuestionLoadedSate extends MessagesState {
  DailyQuestionLoadedSate(this.dailyQuestionEntity);

  final DailyQuestionEntity dailyQuestionEntity;
}
