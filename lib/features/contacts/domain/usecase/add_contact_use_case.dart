import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactUseCase {
  AddContactUseCase({required this.repository});

  final ContactsRepository repository;

  Future<String> call(String email) async {
    return await repository.addContact(email);
  }
}
