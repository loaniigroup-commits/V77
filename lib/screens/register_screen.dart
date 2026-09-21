import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/demo_repository.dart';
import '../widgets/brand.dart';
import 'pending_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState()=>_RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen>{
  final company=TextEditingController(),cr=TextEditingController(),card=TextEditingController(),
      contact=TextEditingController(),mobile=TextEditingController(),email=TextEditingController();
  String? logoName;
  Future<void> pickLogo() async {
    final r=await FilePicker.platform.pickFiles(type:FileType.image);
    if(r!=null)setState(()=>logoName=r.files.single.name);
  }
  void submit(){
    if([company,cr,card,contact,mobile,email].any((x)=>x.text.trim().isEmpty)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Please complete all company information.'))); return;
    }
    final u=DemoRepository.instance.register(companyName:company.text,cr:cr.text,computerCard:card.text,contactPerson:contact.text,mobile:mobile.text,email:email.text);
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>PendingScreen(user:u)),(_)=>false);
  }
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Company Registration')),
    body:SingleChildScrollView(padding:const EdgeInsets.all(20),child:Center(child:ConstrainedBox(
      constraints:const BoxConstraints(maxWidth:600),child:Column(children:[
        const BrandLogo(height:105),const SizedBox(height:16),
        OutlinedButton.icon(onPressed:pickLogo,icon:const Icon(Icons.add_photo_alternate_outlined),label:Text(logoName??'Upload Company Logo')),
        const SizedBox(height:16),
        ...[
          ('Company Name',company,Icons.business),('CR Number',cr,Icons.badge_outlined),
          ('Computer Card Number',card,Icons.credit_card),('Contact Person',contact,Icons.person_outline),
          ('Mobile',mobile,Icons.phone_outlined),('Email',email,Icons.email_outlined)
        ].map((x)=>Padding(padding:const EdgeInsets.only(bottom:12),child:TextField(controller:x.$2,decoration:InputDecoration(labelText:x.$1,prefixIcon:Icon(x.$3))))),
        const SizedBox(height:8),GoldButton(text:'Submit for Approval',onPressed:submit,icon:Icons.verified_user_outlined),
      ]),
    ))),
  );
}
