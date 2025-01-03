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
  ConversationReady({
    required this.conversationId,
    required this.contactName,
    required this.contactImage,
  });

  final String conversationId;
  final String contactName;
  final String contactImage;
}

final class ConversationFailed extends ContactsState {
  ConversationFailed(this.message);

  final String message;
}

final class RecentContactsLoading extends ContactsState {}

final class RecentContactsLoaded extends ContactsState {
  RecentContactsLoaded(this.recentContacts);

  final List<ContactEntity> recentContacts;
}

final class RecentContactsError extends ContactsState {
  RecentContactsError(this.message);

  final String message;
}
