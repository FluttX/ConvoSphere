part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}

class AddContactsEvent extends ContactsEvent {
  AddContactsEvent(this.email);

  final String email;
}
