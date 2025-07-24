import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  late AnimationController _moveFadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _moveUpAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _moveFadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _moveFadeController, curve: Curves.easeOut),
    );
    _moveUpAnimation = Tween<double>(begin: 0.0, end: -200.0).animate(
      CurvedAnimation(parent: _moveFadeController, curve: Curves.easeOut),
    );

    _startSplashFlow();
  }

  Future<void> _startSplashFlow() async {
    await Future.delayed(const Duration(milliseconds: 800));

    await _scaleController.forward();
    await _scaleController.reverse();
    await _moveFadeController.forward();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/stations');
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _moveFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleController, _moveFadeController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _moveUpAnimation.value),
                  child: child,
                ),
              ),
            );
          },
          child: Image.asset('assets/ic_ecobici.png', width: 150, height: 150),
        ),
      ),
    );
  }
}
