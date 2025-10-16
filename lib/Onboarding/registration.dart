import 'package:flutter/material.dart';

import 'Widgets/CustomTextFields.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                SizedBox(height: 20),
                Text(
                  "Hirelens.",
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(child: customTextField(placeholder: "First name")),
                    SizedBox(width: 20),
                    Expanded(child: customTextField(placeholder: "Last name")),
                  ],
                ),

                SizedBox(height: 20),

                customTextField(placeholder: "Enter your email"),
                SizedBox(height: 20),

                customTextField(placeholder: "Which camera do you have?"),
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
                    child: Text("Submit"),
                  ),
                ),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
