import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/Utils/validation.dart';
import 'package:hirelens/Onboarding/repos/onboarding_repo.dart';
import '../AppAlerts/hirelens_alert.dart';
import 'Widgets/CustomTextFields.dart';
import 'Widgets/signinGoogle.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _authRepo = AuthRepo();

  Future<void> handleGoogleSignIn() async {
    try {
      final result = await _authRepo.signInWithGoogle();

      if (result != null) {
        //Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show alert for registration.
        HirelensAlert.show(
          context: context,
          title: 'Login Unsuccessful',
          message:
              'Email you selected is not registered. Kindly try other emails or register with the email.',
          actions: [
            AlertAction(
              title: 'Register Now',
              isPrimary: true,
              onPressed: () {
                // Your action
                Navigator.pushNamed(context, "/register");
              },
            ),
            AlertAction(
              title: 'Cancel',
              onPressed: () {
                // Cancel action
              },
            ),
          ],
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool> handleLogin({
    required String email,
    required String password,
  }) async {
    if (!isValidEmail(email)) {
      HirelensAlert.show(
        context: context,
        title: 'Login Unsuccessful',
        message: 'Please enter a valid email address.',
        actions: [],
      );

      return false;
    } else if (password.length > 6) {
      HirelensAlert.show(
        context: context,
        title: 'Login Unsuccessful',
        message: 'Password length should be more than 6 digits.',
        actions: [],
      );

      return false;
    } else {
      try {
        await _authRepo.login(email: email, password: password);
        //Navigator.pushReplacementNamed(context, '/home');

        return true;
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          HirelensAlert.show(
            context: context,
            title: 'Login Unsuccessful',
            message: "${e.message} Try another method to login.",
            actions: [],
          );
        }

        return false;
        // Show Alert.
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authRepo.initializeGoogleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            width: width - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Hirelens.",
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Every story deserves the right lens 📸",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: 30),

                CustomTextField(
                  placeholder: "Enter your email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),

                CustomTextField(
                  placeholder: "Enter your password",
                  isSecure: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      handleLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text("Login"),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: SignInWithGoogleButton(onPressed: handleGoogleSignIn),
                ),
                SizedBox(height: 10),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not having an Account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                // how far the shadow moves
                                blurRadius: 6.0,
                                // how soft the shadow is
                                color: Colors.grey.withOpacity(
                                  0.4,
                                ), // shadow color
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Create here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
