class CompanyUser {
  final String id;
  final String username;
  final String companyName;
  final String cr;
  final String computerCard;
  final String contactPerson;
  final String mobile;
  final String email;
  final bool approved;
  final bool admin;

  const CompanyUser({
    required this.id,
    required this.username,
    required this.companyName,
    required this.cr,
    required this.computerCard,
    required this.contactPerson,
    required this.mobile,
    required this.email,
    required this.approved,
    this.admin = false,
  });
}

class Consultation {
  final String id;
  final String companyId;
  final String topic;
  final String description;
  final DateTime createdAt;
  final List<String> attachments;
  final List<ConsultationMessage> messages;
  String status;

  Consultation({
    required this.id,
    required this.companyId,
    required this.topic,
    required this.description,
    required this.createdAt,
    this.attachments = const [],
    this.messages = const [],
    this.status = 'New',
  });
}

class ConsultationMessage {
  final String sender;
  final String text;
  final DateTime sentAt;
  const ConsultationMessage(this.sender, this.text, this.sentAt);
}

class AppointmentRequest {
  final String id;
  final String companyId;
  final DateTime preferredDateTime;
  final String topic;
  final String notes;
  String status;

  AppointmentRequest({
    required this.id,
    required this.companyId,
    required this.preferredDateTime,
    required this.topic,
    required this.notes,
    this.status = 'Pending',
  });
}
