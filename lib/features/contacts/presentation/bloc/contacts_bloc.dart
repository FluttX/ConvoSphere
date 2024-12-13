import 'dart:async';

import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';
import 'package:convo_sphere/features/contacts/domain/usecase/add_contact_use_case.dart';
import 'package:convo_sphere/features/contacts/domain/usecase/fetch_contacts_use_case.dart';
import 'package:convo_sphere/features/conversation/domain/usecase/check_or_create_conversation_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({
    required this.fetchContactsUseCase,
    required this.addContactUseCase,
    required this.checkOrCreateConversationUseCase,
  }) : super(ContactsInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
    on<AddContactsEvent>(_onAddContact);
    on<CheckOrCreateConversationEvent>(_onCheckOrCreateConversation);
  }

  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  Future<void> _onFetchContacts(
    FetchContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUseCase.call();
      emit(ContactsLoaded(List.from(contacts)));
    } catch (e) {
      emit(ContactsError('Failed to fetch contacts'));
    }
  }

  Future<void> _onAddContact(
    AddContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final message = await addContactUseCase.call(event.email);
      emit(ContactAdded(message));
      add(FetchContactsEvent());
    } catch (e) {
      emit(ContactsError('Failed to add contacts'));
    }
  }

  Future<void> _onCheckOrCreateConversation(
    CheckOrCreateConversationEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final conversationId = await checkOrCreateConversationUseCase.call(
        event.contactId,
      );
      emit(ConversationReady(
        conversationId: conversationId,
        contactName: event.contactName,
      ));
    } catch (e) {
      emit(ConversationFailed('Failed to check or create conversation'));
    }
  }
}
