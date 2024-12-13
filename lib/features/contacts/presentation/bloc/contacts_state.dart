part of 'contacts_bloc.dart';

abstract class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsLoaded extends ContactsState {
  ContactsLoaded(this.contacts);

  List<ContactEntity> contacts;
}

final class ContactsError extends ContactsState {
  ContactsError(this.message);

  final String message;
}

final class ContactAdded extends ContactsState {
  ContactAdded(this.message);

  final String message;
}

final class ConversationReady extends ContactsState {
  ConversationReady({required this.conversationId, required this.contactName});

  final String conversationId;
  final String contactName;
}

final class ConversationFailed extends ContactsState {
  ConversationFailed(this.message);

  final String message;
}
