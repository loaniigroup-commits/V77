import 'package:flutter/material.dart';
import '../services/demo_repository.dart';
import '../widgets/brand.dart';
import 'admin_screen.dart';
import 'home_screen.dart';
import 'pending_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState()=>_LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  final user=TextEditingController(), pass=TextEditingController();
  String? error;
  void login(){
    final u=DemoRepository.instance.login(user.text.trim(),pass.text);
    if(u==null){setState(()=>error='Invalid username or password');return;}
    final page=u.admin ? const AdminScreen() : (u.approved ? HomeScreen(user:u) : PendingScreen(user:u));
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>page));
  }
  @override Widget build(BuildContext context)=>Scaffold(
    body:SafeArea(child:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(24),child:ConstrainedBox(
      constraints:const BoxConstraints(maxWidth:460),child:Column(children:[
        const BrandLogo(height:170), const SizedBox(height:30),
        Text('Secure Client Portal',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w700)),
        const SizedBox(height:24),
        TextField(controller:user,decoration:const InputDecoration(labelText:'Username / Email',prefixIcon:Icon(Icons.person_outline))),
        const SizedBox(height:14),
        TextField(controller:pass,obscureText:true,decoration:const InputDecoration(labelText:'Password',prefixIcon:Icon(Icons.lock_outline))),
        if(error!=null)...[const SizedBox(height:10),Text(error!,style:const TextStyle(color:Colors.redAccent))],
        const SizedBox(height:22),GoldButton(text:'Login',onPressed:login,icon:Icons.login),
        const SizedBox(height:12),
        TextButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const RegisterScreen())),child:const Text('Create Company Account')),
        const SizedBox(height:12),
        Text('Demo: client / client123   •   admin / admin123',style:Theme.of(context).textTheme.bodySmall,textAlign:TextAlign.center),
      ]),
    )))),
  );
}
