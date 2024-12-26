import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.username,
    required super.profileImage,
    required super.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['contact_id'],
      username: json['username'],
      profileImage: json['profile_image'],
      email: json['email'],
    );
  }
}
