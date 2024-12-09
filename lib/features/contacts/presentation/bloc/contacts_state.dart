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
