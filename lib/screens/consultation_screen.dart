import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/demo_repository.dart';
import '../theme.dart';
import '../widgets/brand.dart';

class ConsultationScreen extends StatefulWidget {
  final CompanyUser user;
  const ConsultationScreen({super.key, required this.user});
  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final topic = TextEditingController();
  final desc = TextEditingController();
  List<String> files = [];

  @override
  void dispose() {
    topic.dispose();
    desc.dispose();
    super.dispose();
  }

  Future<void> pick() async {
    final r = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (r != null) {
      setState(() => files = r.files.map((e) => e.name).toList());
    }
  }

  void send() {
    if (topic.text.trim().isEmpty || desc.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the subject and description.')),
      );
      return;
    }
    final c = DemoRepository.instance.addConsultation(
      widget.user.id,
      topic.text.trim(),
      desc.text.trim(),
      List<String>.from(files),
    );
    topic.clear();
    desc.clear();
    setState(() => files = []);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${c.id} submitted successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mine = DemoRepository.instance.consultations
        .where((c) => c.companyId == widget.user.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Legal Consultation')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: ExpertsTheme.navy2,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ExpertsTheme.gold.withValues(alpha: .35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Consultation', style: TextStyle(color: ExpertsTheme.gold, fontSize: 21, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                TextField(controller: topic, decoration: const InputDecoration(labelText: 'Topic / Subject', prefixIcon: Icon(Icons.gavel_rounded))),
                const SizedBox(height: 12),
                TextField(controller: desc, minLines: 4, maxLines: 8, decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true)),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: pick,
                  icon: const Icon(Icons.attach_file),
                  label: Text(files.isEmpty ? 'Attach Documents' : '${files.length} document(s) selected'),
                  style: OutlinedButton.styleFrom(foregroundColor: ExpertsTheme.gold, side: const BorderSide(color: ExpertsTheme.gold)),
                ),
                const SizedBox(height: 12),
                GoldButton(text: 'Send Consultation', onPressed: send, icon: Icons.send_rounded),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Text('My Consultations', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (mine.isEmpty)
            const Card(child: Padding(padding: EdgeInsets.all(22), child: Center(child: Text('No consultations yet.', style: TextStyle(color: ExpertsTheme.ink))))),
          ...mine.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFFF1E6C9), child: Icon(Icons.description_outlined, color: Color(0xFFB88628))),
                    title: Text(c.topic, style: const TextStyle(color: ExpertsTheme.ink, fontWeight: FontWeight.w700)),
                    subtitle: Text('${c.id}  •  ${c.status}', style: const TextStyle(color: Colors.black54)),
                    trailing: const Icon(Icons.chevron_right, color: ExpertsTheme.ink),
                    onTap: () => _showDetails(c),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _showDetails(Consultation c) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ExpertsTheme.navy2,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(c.topic, style: const TextStyle(color: ExpertsTheme.gold, fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(c.description, style: const TextStyle(color: Colors.white, height: 1.5)),
              const SizedBox(height: 14),
              Text('Status: ${c.status}', style: const TextStyle(color: ExpertsTheme.softGold)),
              if (c.attachments.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('Attachments', style: TextStyle(color: ExpertsTheme.gold, fontWeight: FontWeight.bold)),
                ...c.attachments.map((f) => ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.attach_file, color: ExpertsTheme.softGold), title: Text(f, style: const TextStyle(color: Colors.white)))),
              ],
              if (c.messages.isNotEmpty) ...[
                const Divider(height: 28),
                ...c.messages.map((m) => ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.chat_bubble_outline, color: ExpertsTheme.gold), title: Text(m.sender, style: const TextStyle(color: ExpertsTheme.gold)), subtitle: Text(m.text, style: const TextStyle(color: Colors.white70)))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
