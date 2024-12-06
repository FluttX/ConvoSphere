import 'dart:async';

import 'package:convo_sphere/features/conversation/domain/entities/conversation_entity.dart';
import 'package:convo_sphere/features/conversation/domain/usecase/fetch_conversations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc({required this.conversationsUseCase})
      : super(ConversationsInitial()) {
    on<FetchConversationsEvent>(_onFetchConversations);
  }

  final FetchConversationsUseCase conversationsUseCase;

  Future<void> _onFetchConversations(
    FetchConversationsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());

    try {
      final conversations = await conversationsUseCase.call();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ConversationsError(e.toString()));
    }
  }
}
