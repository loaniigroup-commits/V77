import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';
import 'appointment_screen.dart';
import 'consultation_screen.dart';

class HomeScreen extends StatefulWidget {
  final CompanyUser user;
  const HomeScreen({super.key,required this.user});
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  int index=0;
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(
      centerTitle:false,
      title:Row(children:[
        const CircleAvatar(backgroundColor:ExpertsTheme.gold,child:Icon(Icons.account_balance,color:ExpertsTheme.navy)),
        const SizedBox(width:10),
        Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('Welcome',style:TextStyle(fontSize:12,fontWeight:FontWeight.w400)),
          Text(widget.user.companyName,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w700)),
        ])
      ]),
      actions:[IconButton(onPressed:(){},icon:const Badge(child:Icon(Icons.notifications_none_rounded)))],
    ),
    body:ListView(padding:const EdgeInsets.all(16),children:[
      Container(
        height:145,padding:const EdgeInsets.all(20),
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(16),
          image:const DecorationImage(
            image:AssetImage('assets/images/court_background.png'),
            fit:BoxFit.cover,
            alignment:Alignment.centerRight,
          ),
          border:Border.all(color:ExpertsTheme.gold.withValues(alpha:.35)),
        ),
        child:const Align(alignment:Alignment.centerLeft,child:SizedBox(width:240,child:Text(
          '“Your Legal Partner\nfor a Stronger Business”',
          style:TextStyle(color:Colors.white,fontSize:22,fontFamily:'serif',height:1.35,fontWeight:FontWeight.w600),
        ))),
      ),
      const SizedBox(height:16),
      _Service(icon:Icons.description_rounded,title:'Legal Consultation',subtitle:'Get professional legal advice.',
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ConsultationScreen(user:widget.user)))),
      const SizedBox(height:14),
      _Service(icon:Icons.calendar_month_rounded,title:'Book Appointment',subtitle:'Request a meeting with our team.',
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>AppointmentScreen(user:widget.user)))),
    ]),
    bottomNavigationBar:NavigationBar(
      selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),
      backgroundColor:ExpertsTheme.navy2,indicatorColor:ExpertsTheme.gold.withValues(alpha:.2),
      destinations:const [
        NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home,color:ExpertsTheme.gold),label:'Home'),
        NavigationDestination(icon:Icon(Icons.chat_bubble_outline),label:'Consultations'),
        NavigationDestination(icon:Icon(Icons.calendar_month_outlined),label:'Appointments'),
        NavigationDestination(icon:Icon(Icons.person_outline),label:'Profile'),
      ],
    ),
  );
}
class _Service extends StatelessWidget{
  final IconData icon;final String title,subtitle;final VoidCallback onTap;
  const _Service({required this.icon,required this.title,required this.subtitle,required this.onTap});
  @override Widget build(BuildContext context)=>Material(
    color:Colors.white,borderRadius:BorderRadius.circular(14),
    child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(14),child:Padding(
      padding:const EdgeInsets.all(17),child:Row(children:[
        Container(width:50,height:50,decoration:BoxDecoration(color:const Color(0xFFF1E6C9),borderRadius:BorderRadius.circular(10)),child:Icon(icon,color:const Color(0xFFB88628))),
        const SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(title,style:const TextStyle(color:ExpertsTheme.ink,fontWeight:FontWeight.w800,fontSize:16)),
          const SizedBox(height:4),Text(subtitle,style:const TextStyle(color:Color(0xFF66717C),fontSize:12)),
        ])),
        const Icon(Icons.arrow_forward_ios_rounded,color:ExpertsTheme.ink,size:16),
      ]),
    )),
  );
}
