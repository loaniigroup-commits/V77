import 'package:flutter/material.dart';
import '../services/demo_repository.dart';
import '../theme.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget{
  const AdminScreen({super.key});
  @override State<AdminScreen> createState()=>_AdminScreenState();
}
class _AdminScreenState extends State<AdminScreen>{
  @override Widget build(BuildContext context){
    final r=DemoRepository.instance;
    final clients=r.users.where((u)=>!u.admin).toList();
    final pending=clients.where((u)=>!u.approved).length;
    return Scaffold(
      drawer:Drawer(backgroundColor:ExpertsTheme.navy2,child:SafeArea(child:ListView(children:const[
        DrawerHeader(child:Center(child:Text('EXPERTS',style:TextStyle(color:ExpertsTheme.gold,fontSize:26,fontWeight:FontWeight.bold)))),
        ListTile(leading:Icon(Icons.dashboard_outlined),title:Text('Dashboard')),
        ListTile(leading:Icon(Icons.business_outlined),title:Text('Clients Management')),
        ListTile(leading:Icon(Icons.gavel_outlined),title:Text('Consultations')),
        ListTile(leading:Icon(Icons.event_outlined),title:Text('Appointments')),
        ListTile(leading:Icon(Icons.bar_chart_outlined),title:Text('Reports')),
      ]))),
      appBar:AppBar(title:const Text('Admin Dashboard'),actions:[
        IconButton(onPressed:(){},icon:const Badge(child:Icon(Icons.notifications_none))),
        IconButton(onPressed:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const LoginScreen()),(_)=>false),icon:const Icon(Icons.logout))
      ]),
      body:ListView(padding:const EdgeInsets.all(16),children:[
        GridView.count(crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:1.45,children:[
          _Metric('$pending','Pending Accounts',Icons.group_outlined),
          _Metric('${r.consultations.where((c)=>c.status=='New').length}','New Consultations',Icons.description_outlined),
          _Metric('${r.appointments.where((a)=>a.status=='Pending').length}','Pending Appointments',Icons.calendar_month_outlined),
          _Metric('${clients.length}','Total Clients',Icons.groups_rounded),
        ]),
        const SizedBox(height:24),
        const Text('Clients Management',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800)),
        const SizedBox(height:10),
        ...clients.map((u)=>Card(child:ListTile(
          leading:CircleAvatar(backgroundColor:ExpertsTheme.gold.withValues(alpha:.2),child:const Icon(Icons.business,color:ExpertsTheme.gold)),
          title:Text(u.companyName,style:const TextStyle(color:ExpertsTheme.ink,fontWeight:FontWeight.w700)),
          subtitle:Text(u.email,style:const TextStyle(color:Colors.black54)),
          trailing:Chip(label:Text(u.approved?'Approved':'Pending')),
        ))),
        const SizedBox(height:22),
        const Text('Consultations',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800)),
        const SizedBox(height:10),
        ...r.consultations.map((c)=>Card(child:ListTile(
          title:Text(c.topic,style:const TextStyle(color:ExpertsTheme.ink,fontWeight:FontWeight.w700)),
          subtitle:Text(c.id,style:const TextStyle(color:Colors.black54)),
          trailing:PopupMenuButton<String>(iconColor:ExpertsTheme.ink,onSelected:(v)=>setState(()=>c.status=v),itemBuilder:(_)=>['New','Under Review','Answered','Closed'].map((s)=>PopupMenuItem(value:s,child:Text(s))).toList()),
        ))),
      ]),
    );
  }
}
class _Metric extends StatelessWidget{
  final String value,label;final IconData icon;const _Metric(this.value,this.label,this.icon);
  @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(14),child:Row(children:[
    Icon(icon,color:const Color(0xFF143654),size:31),const SizedBox(width:12),
    Expanded(child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(value,style:const TextStyle(color:ExpertsTheme.ink,fontSize:25,fontWeight:FontWeight.w900)),
      Text(label,style:const TextStyle(color:Colors.black54,fontSize:11)),
    ]))
  ])));
}
