import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import 'package:hirelens/Onboarding/repos/onboarding_repo.dart';

class WelcomePage extends StatefulWidget {
  final RegUser user;
  final VoidCallback onSuccessfulRegistration;

  const WelcomePage({
    super.key,
    required this.user,
    required this.onSuccessfulRegistration,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthRepo _authRepo = AuthRepo();
  late Future<void> _registrationFuture;

  @override
  void initState() {
    super.initState();
    _registrationFuture = _registerUser();
  }

  Future<void> _registerUser() async {
    print("❤️Welcome page register method called");
    await _authRepo.register(user: widget.user, password: widget.user.password);
  }

  // Retry registration
  void _retryRegistration() {
    setState(() {
      _registrationFuture = _registerUser();
    });
  }

  // Get user-friendly error message
  String _getErrorMessage(dynamic error) {
    String errorMessage = error.toString().toLowerCase();

    if (errorMessage.contains('network') ||
        errorMessage.contains('connection') ||
        errorMessage.contains('timeout')) {
      return 'No internet connection. Please check your network and try again.';
    } else if (errorMessage.contains('email-already-in-use')) {
      return 'This email is already registered. Please use a different email or try logging in.';
    } else if (errorMessage.contains('invalid-email')) {
      return 'The email address is invalid. Please check and try again.';
    } else if (errorMessage.contains('weak-password')) {
      return 'The password is too weak. Please use a stronger password.';
    } else if (errorMessage.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    } else if (errorMessage.contains('operation-not-allowed')) {
      return 'Registration is currently disabled. Please contact support.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Data of user to be registered");
    widget.user.printAsJson();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _registrationFuture,
            builder: (context, snapshot) {
              // Loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingScreen();
              }

              // Error state
              if (snapshot.hasError) {
                return _buildErrorScreen(snapshot.error);
              }

              // Success state
              if (snapshot.connectionState == ConnectionState.done) {
                final first = widget.user.firstName;
                final last = widget.user.lastName;

                //widget.onSuccessfulRegistration();

                return _buildSuccessScreen(firstName: first, lastName: last);
              }

              // Fallback (should not reach here)
              return _buildLoadingScreen();
            },
          ),
        ),
      ),
    );
  }

  // Loading Screen
  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          Text(
            "Creating your account...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "This will only take a moment",
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  // Error Screen
  Widget _buildErrorScreen(dynamic error) {
    String errorMessage = _getErrorMessage(error);
    bool isNetworkError =
        errorMessage.contains('internet') || errorMessage.contains('network');

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isNetworkError
                  ? Icons.wifi_off_rounded
                  : Icons.error_outline_rounded,
              size: 60,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 20),

          // Error Title
          Text(
            isNetworkError ? "Connection Error" : "Registration Failed",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Error Message
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Retry Button
          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: _retryRegistration,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh_rounded, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Try Again",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Go Back Button
          SizedBox(
            width: double.infinity,
            height: 30,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Go Back",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Success Screen
  Widget _buildSuccessScreen({
    required String firstName,
    required String lastName,
  }) {
    // Call the callback after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSuccessfulRegistration();
    });

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success Animation/Image
          Image.asset(
            "assets/images/Welcome-Page-Image.png",
            width: 200,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          SizedBox(height: 20),
          Text(
            "Welcome $firstName $lastName",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your next great shot starts right here — with Hirelens.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
