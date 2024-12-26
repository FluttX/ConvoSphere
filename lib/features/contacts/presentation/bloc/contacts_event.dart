part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}

class FetchRecentContactsEvent extends ContactsEvent {}

class AddContactsEvent extends ContactsEvent {
  AddContactsEvent(this.email);

  final String email;
}

class CheckOrCreateConversationEvent extends ContactsEvent {
  CheckOrCreateConversationEvent(this.contactEntity);

  final ContactEntity contactEntity;
}
