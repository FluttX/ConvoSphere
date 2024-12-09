import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';
import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUseCase {
  FetchContactsUseCase({required this.repository});

  final ContactsRepository repository;

  Future<List<ContactEntity>> call() async {
    return await repository.fetchContacts();
  }
}
