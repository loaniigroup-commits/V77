import '../models/models.dart';

class DemoRepository {
  DemoRepository._();
  static final instance = DemoRepository._();

  final users = <CompanyUser>[
    const CompanyUser(
      id: 'admin-1', username: 'admin', companyName: 'Experts Administration',
      cr: '', computerCard: '', contactPerson: 'Administrator', mobile: '',
      email: 'admin@experts.local', approved: true, admin: true,
    ),
    const CompanyUser(
      id: 'client-1', username: 'client', companyName: 'Demo Client Company',
      cr: '123456', computerCard: 'CC-7788', contactPerson: 'Client Manager',
      mobile: '+974 5000 0000', email: 'client@example.com', approved: true,
    ),
    const CompanyUser(
      id: 'pending-1', username: 'pending', companyName: 'Pending Company',
      cr: '998877', computerCard: 'CC-9911', contactPerson: 'Pending Manager',
      mobile: '+974 5111 1111', email: 'pending@example.com', approved: false,
    ),
  ];

  final consultations = <Consultation>[
    Consultation(
      id: 'CON-2026-0001', companyId: 'client-1', topic: 'Contract review',
      description: 'Please review the attached service agreement.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Answered',
      messages: [
        ConsultationMessage('Experts', 'The agreement has been reviewed. Please see our comments.', DateTime.now().subtract(const Duration(days: 1))),
      ],
    ),
    Consultation(
      id: 'CON-2026-0002', companyId: 'client-1', topic: 'Debt collection',
      description: 'Advice regarding collection procedure.',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      status: 'Under Review',
    ),
  ];

  final appointments = <AppointmentRequest>[];

  CompanyUser? login(String username, String password) {
    final passwords = {'admin':'admin123','client':'client123','pending':'pending123'};
    if (passwords[username] != password) return null;
    try { return users.firstWhere((u) => u.username == username); } catch (_) { return null; }
  }

  CompanyUser register({
    required String companyName, required String cr, required String computerCard,
    required String contactPerson, required String mobile, required String email,
  }) {
    final user = CompanyUser(
      id: 'client-${users.length + 1}', username: email, companyName: companyName,
      cr: cr, computerCard: computerCard, contactPerson: contactPerson,
      mobile: mobile, email: email, approved: false,
    );
    users.add(user);
    return user;
  }

  Consultation addConsultation(String companyId, String topic, String description, List<String> files) {
    final c = Consultation(
      id: 'CON-2026-${(consultations.length + 1).toString().padLeft(4, '0')}',
      companyId: companyId, topic: topic, description: description,
      createdAt: DateTime.now(), attachments: files,
    );
    consultations.insert(0, c);
    return c;
  }

  AppointmentRequest addAppointment(String companyId, DateTime when, String topic, String notes) {
    final a = AppointmentRequest(
      id: 'APT-2026-${(appointments.length + 1).toString().padLeft(4, '0')}',
      companyId: companyId, preferredDateTime: when, topic: topic, notes: notes,
    );
    appointments.insert(0, a);
    return a;
  }
}
