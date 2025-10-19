import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/Utils/validation.dart';
import 'package:hirelens/Onboarding/portfolio_details.dart';
import 'Widgets/CustomTextFields.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _controller = PageController();

  int _currentPage = -1;
  final int totalSteps = 5;

  bool userIsSoloPhotographer = false;

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
                    children: [
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

                      _PersonalDetails(isUserSolo: userIsSoloPhotographer),
                      const _LocationDetails(),
                      PortfolioDetails(),
                      const _WelcomePage(),
                    ],
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

// Type  Selector

class StudioSoloSelector extends StatelessWidget {
  final double size;
  VoidCallback onStudioTap;
  VoidCallback onSoloTap;

  StudioSoloSelector({
    super.key,
    required this.onStudioTap,
    required this.onSoloTap,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 120,
      child: Column(
        children: [
          const Text(
            "Tell us, Who are you?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---- Studio ----
              GestureDetector(
                onTap: onStudioTap,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          scale: 1,
                          image: AssetImage('assets/images/studio.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Studio",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // ---- Separator ----
              Container(
                width: 2,
                height: size - 50,
                color: Colors.white.withOpacity(0.1),
                margin: const EdgeInsets.symmetric(horizontal: 30),
              ),

              // ---- Solo ----
              GestureDetector(
                onTap: onSoloTap,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: const DecorationImage(
                          scale: 1,
                          image: AssetImage('assets/images/solo.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Solo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PersonalDetails extends StatelessWidget {
  bool isUserSolo = false;

  _PersonalDetails({super.key, required this.isUserSolo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isUserSolo) ...[
          const Text(
            "Tell us a bit about yourself.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: CustomTextField(placeholder: "First name")),
              SizedBox(width: 20),
              Expanded(child: CustomTextField(placeholder: "Last name")),
            ],
          ),

          SizedBox(height: 20),

          CustomTextField(
            placeholder: "Enter your email",
            enableVerification: true,
            validator: isValidEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),

          CustomTextField(placeholder: "Enter your password", isSecure: true),
          SizedBox(height: 20),

          CustomTextField(placeholder: "Confirm your password", isSecure: true),
        ] else ...[
          const Text(
            "Verify studio with GST Number",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 60),

          CustomTextField(
            placeholder: "Enter your GST Number",
            enableVerification: true,
            validator: isValidGST,
          ),

          SizedBox(height: 40),

          CustomTextField(
            placeholder: "Enter phone number",
            enableVerification: true,
            validator: (value) => value.length == 10,
          ),
        ],
      ],
    );
  }
}

class _LocationDetails extends StatelessWidget {
  const _LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Tell us where you live?",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 20),

        CustomTextField(placeholder: "Enter your address"),
        SizedBox(height: 20),

        CustomTextField(placeholder: "Radius of area of service in KMs"),
        SizedBox(height: 20),

        CustomTextField(placeholder: "Enter the city you live in"),
      ],
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Welcome onboard, Utsav"));
  }
}
