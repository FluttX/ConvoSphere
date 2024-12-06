part of 'conversations_bloc.dart';

abstract class ConversationsState {}

final class ConversationsInitial extends ConversationsState {}

final class ConversationsLoading extends ConversationsState {}

final class ConversationsLoaded extends ConversationsState {
  ConversationsLoaded(this.conversations);

  final List<ConversationEntity> conversations;
}

final class ConversationsError extends ConversationsState {
  ConversationsError(this.message);

  final String message;
}
