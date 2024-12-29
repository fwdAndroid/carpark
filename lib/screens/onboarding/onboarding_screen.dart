import 'package:carpark/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Real-Time Traffic Updates",
      "description":
          "Stay informed about traffic conditions and navigate smarter.",
      "image": "assets/traffic_map.png" // Mock live map image.
    },
    {
      "title": "Find and Reserve Parking",
      "description": "Easily locate and book parking spots near you.",
      "image": "assets/parking_spot.png" // Parking spot illustration.
    },
    {
      "title": "Report and Avoid Incidents",
      "description":
          "Contribute to safer roads by reporting accidents and hazards.",
      "image": "assets/report_incident.png" // Accident reporting illustration.
    },
  ];

  void _onSkip() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  void _onNext() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingContent(
                  title: onboardingData[index]['title']!,
                  description: onboardingData[index]['description']!,
                  image: onboardingData[index]['image']!,
                );
              },
            ),
          ),
          // Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onSkip,
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _onNext,
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? "Finish"
                        : "Next",
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

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 250, fit: BoxFit.cover),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
