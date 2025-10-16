import 'package:flutter/material.dart';
import 'Widgets/CustomTextFields.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

                customTextField(placeholder: "Enter your email"),
                SizedBox(height: 20),

                customTextField(
                  placeholder: "Enter your password",
                  isSecure: true,
                ),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
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

  Widget customTextField({required String placeholder, bool isSecure = false}) {
    return CustomTextField(placeholder: placeholder, isSecure: isSecure);
  }
}
