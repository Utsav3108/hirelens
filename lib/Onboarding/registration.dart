import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration_pages/camera_options.dart';

import 'package:hirelens/Onboarding/registration_pages/location_details.dart';
import 'package:hirelens/Onboarding/registration_pages/personal_details.dart';
import 'package:hirelens/Onboarding/registration_pages/portfolio_details.dart';
import 'package:hirelens/Onboarding/registration_pages/studio_selection.dart';
import 'package:hirelens/Onboarding/registration_pages/welcome_page.dart';
import 'package:hirelens/Onboarding/registration_pages/work_details.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _controller = PageController();

  bool userIsSoloPhotographer = false;

  late List<Widget> registrationPages;

  int _currentPage = -1;
  late int totalSteps;

  void _nextPage() {
    if (_currentPage < totalSteps - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Submit logic
      Navigator.pushNamed(context, "/home");
      print("✅ Registration Submitted!");
    }
  }

  void _prevPage() {
    if (_currentPage > -1) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    registrationPages = [
      //PopupMenuExample(),
      Align(
        alignment: AlignmentGeometry.center,
        child: StudioSoloSelector(
          onStudioTap: () {
            setState(() {
              userIsSoloPhotographer = false;
              _nextPage();
            });
          },
          onSoloTap: () {
            setState(() {
              userIsSoloPhotographer = true;
              _nextPage();
            });
          },
        ),
      ),

      PersonalDetails(isUserSolo: userIsSoloPhotographer),
      CameraOptions(isUserSolo: userIsSoloPhotographer),
      WorkDetails(isUserSolo: userIsSoloPhotographer),
      PortfolioDetails(),

      const WelcomePage(),
    ];

    totalSteps = registrationPages.length;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 120),

              // --- Title ---
              const Text(
                "Hirelens.",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),
              // --- PageView (Steps) ---
              SizedBox(
                height: 350,
                child: Center(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    children: registrationPages,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- Buttons (Next / Back) ---
              if (_currentPage > 0) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentPage > 0 && _currentPage < totalSteps - 1) ...[
                      ElevatedButton(
                        onPressed: _prevPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Back"),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(150, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Next"),
                      ),
                    ] else
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(150, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Let's go"),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
              ],

              // --- Bottom Sign-in ---
              if (_currentPage < totalSteps - 1)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Already have an Account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
