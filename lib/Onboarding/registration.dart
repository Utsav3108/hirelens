import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 38, 38, 1),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                // Shadow color with opacity
                offset: const Offset(0, 4),
                // X, Y offset of the shadow
                blurRadius: 8,
                // Blurriness of the shadow
                spreadRadius: 2, // How much the shadow spreads
              ),
            ],
          ),
          height: 300,
          width: 300,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Center(child: Text("Hirelens")),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Email."),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Password."),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have an Account? Sign In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
