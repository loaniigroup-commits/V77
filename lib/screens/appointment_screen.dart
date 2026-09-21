import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../services/demo_repository.dart';
import '../widgets/brand.dart';

class AppointmentScreen extends StatefulWidget{
  final CompanyUser user;
  const AppointmentScreen({super.key,required this.user});
  @override State<AppointmentScreen> createState()=>_AppointmentScreenState();
}
class _AppointmentScreenState extends State<AppointmentScreen>{
  DateTime? when; final topic=TextEditingController(),notes=TextEditingController();
  Future<void> choose() async{
    final d=await showDatePicker(context:context,firstDate:DateTime.now(),lastDate:DateTime.now().add(const Duration(days:365)),initialDate:DateTime.now());
    if(d==null)return;
    if(!mounted)return;
    final t=await showTimePicker(context:context,initialTime:TimeOfDay.now());
    if(t!=null)setState(()=>when=DateTime(d.year,d.month,d.day,t.hour,t.minute));
  }
  void send(){
    if(when==null||topic.text.trim().isEmpty)return;
    final a=DemoRepository.instance.addAppointment(widget.user.id,when!,topic.text.trim(),notes.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${a.id} requested. Waiting for confirmation.')));
  }
  @override Widget build(BuildContext context){
    final mine=DemoRepository.instance.appointments.where((a)=>a.companyId==widget.user.id).toList();
    return Scaffold(appBar:AppBar(title:const Text('Book Appointment')),body:ListView(padding:const EdgeInsets.all(20),children:[
      TextField(controller:topic,decoration:const InputDecoration(labelText:'Meeting Topic')),
      const SizedBox(height:12),TextField(controller:notes,minLines:3,maxLines:6,decoration:const InputDecoration(labelText:'Notes')),
      const SizedBox(height:12),OutlinedButton.icon(onPressed:choose,icon:const Icon(Icons.event),label:Text(when==null?'Choose Preferred Date & Time':DateFormat('dd MMM yyyy • hh:mm a').format(when!))),
      const SizedBox(height:14),GoldButton(text:'Request Appointment',onPressed:send,icon:Icons.calendar_month),
      if(mine.isNotEmpty)...[const SizedBox(height:28),Text('My Appointments',style:Theme.of(context).textTheme.titleLarge),...mine.map((a)=>Card(child:ListTile(title:Text(a.topic),subtitle:Text('${DateFormat('dd MMM yyyy • hh:mm a').format(a.preferredDateTime)}\n${a.status}'))))]
    ]));
  }
}
