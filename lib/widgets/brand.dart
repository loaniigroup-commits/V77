import 'package:flutter/material.dart';
import '../theme.dart';

class BrandLogo extends StatelessWidget {
  final double height;
  const BrandLogo({super.key,this.height=150});
  @override Widget build(BuildContext context)=>Image.asset('assets/images/experts_logo.png',height:height,fit:BoxFit.contain);
}

class GoldButton extends StatelessWidget {
  final String text; final VoidCallback? onPressed; final IconData? icon;
  const GoldButton({super.key,required this.text,required this.onPressed,this.icon});
  @override Widget build(BuildContext context)=>SizedBox(
    width:double.infinity,height:52,
    child:DecoratedBox(
      decoration:BoxDecoration(
        gradient:const LinearGradient(colors:[Color(0xFFF1D16D),Color(0xFFC8942D)]),
        borderRadius:BorderRadius.circular(11),
        boxShadow:[BoxShadow(color:ExpertsTheme.gold.withValues(alpha:.22),blurRadius:12,offset:const Offset(0,5))]
      ),
      child:ElevatedButton.icon(
        onPressed:onPressed,
        icon:Icon(icon??Icons.arrow_forward_rounded,size:20),
        label:Text(text,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:15)),
        style:ElevatedButton.styleFrom(
          backgroundColor:Colors.transparent,shadowColor:Colors.transparent,
          foregroundColor:ExpertsTheme.navy,
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(11)),
        ),
      ),
    ),
  );
}
