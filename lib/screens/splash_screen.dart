import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/brand.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    Timer(const Duration(milliseconds: 1900), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }
  @override void dispose(){ c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(children:[
      Positioned.fill(child: CustomPaint(painter: _GoldLines())),
      Center(child: FadeTransition(
        opacity: CurvedAnimation(parent: c, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween(begin:.92,end:1.0).animate(CurvedAnimation(parent:c,curve:Curves.easeOutBack)),
          child: const BrandLogo(height: 230),
        ),
      )),
    ]),
  );
}
class _GoldLines extends CustomPainter {
  @override void paint(Canvas canvas, Size s) {
    final p = Paint()..color = ExpertsTheme.gold.withOpacity(.18)..style = PaintingStyle.stroke..strokeWidth = 1.2;
    canvas.drawArc(Rect.fromLTWH(-s.width*.25,s.height*.08,s.width*.9,s.width*.9),-.8,2.0,false,p);
    canvas.drawArc(Rect.fromLTWH(s.width*.35,s.height*.55,s.width*.9,s.width*.9),2.5,2.0,false,p);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
