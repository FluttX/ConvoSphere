import 'dart:async';
import 'dart:developer';

import 'package:convo_sphere/core/services/socket_service.dart';
import 'package:convo_sphere/features/conversation/domain/entities/conversation_entity.dart';
import 'package:convo_sphere/features/conversation/domain/usecase/fetch_conversations_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc({
    required FetchConversationsUseCase conversationsUseCase,
  })  : _conversationsUseCase = conversationsUseCase,
        super(ConversationsInitial()) {
    on<FetchConversationsEvent>(_onFetchConversations);
    _initializeSocketListener();
  }

  final FetchConversationsUseCase _conversationsUseCase;
  final SocketService _socketService = SocketService();

  void _initializeSocketListener() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
    } catch (e) {
      log(
        ' - Error initializing socket listener: ${e.toString()}',
        name: 'Error',
      );
    }
  }

  Future<void> _onFetchConversations(
    FetchConversationsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());

    try {
      final conversations = await _conversationsUseCase.call();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ConversationsError(e.toString()));
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversationsEvent());
  }
}
