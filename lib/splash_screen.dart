import 'dart:async';

import 'package:carpark/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class UrbanFlowScreen extends StatefulWidget {
  @override
  _UrbanFlowScreenState createState() => _UrbanFlowScreenState();
}

class _UrbanFlowScreenState extends State<UrbanFlowScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    Timer(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Cityscape Background
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CityscapePainter(),
          ),
          // Moving Traffic
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: 200,
                left:
                    MediaQuery.of(context).size.width * (_animation.value % 1),
                child: Icon(Icons.directions_car, color: Colors.red, size: 24),
              );
            },
          ),
          // Parking Icons
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: AnimatedOpacity(
              opacity: _animation.value > 0.5 ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: Icon(Icons.local_parking, color: Colors.blue, size: 36),
            ),
          ),
          // Logo and Tagline
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo.png', width: 100, height: 100),
                Text(
                  "Urban Flow",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Optimizing Traffic, Simplifying Parking",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CityscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final roadPaint = Paint()..color = Colors.white;

    // Draw buildings
    canvas.drawRect(Rect.fromLTWH(50, 300, 100, 200), paint);
    canvas.drawRect(Rect.fromLTWH(200, 250, 80, 250), paint);

    // Draw road
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 150, size.width, 100),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
