import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.userId,
    required super.username,
    required super.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['contact_id'],
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
