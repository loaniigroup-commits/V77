import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/brand.dart';
import 'login_screen.dart';

class PendingScreen extends StatelessWidget {
  final CompanyUser user;
  const PendingScreen({super.key,required this.user});
  @override Widget build(BuildContext context)=>Scaffold(
    body:SafeArea(child:Center(child:Padding(padding:const EdgeInsets.all(28),child:ConstrainedBox(
      constraints:const BoxConstraints(maxWidth:520),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
        const BrandLogo(height:150),const SizedBox(height:28),
        const Icon(Icons.hourglass_top_rounded,size:58),const SizedBox(height:16),
        Text('Pending Approval',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
        const SizedBox(height:12),Text('${user.companyName}\nYour company account has been submitted to Experts Administration.',textAlign:TextAlign.center),
        const SizedBox(height:28),GoldButton(text:'Back to Login',onPressed:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const LoginScreen()))),
      ]),
    )))),
  );
}
