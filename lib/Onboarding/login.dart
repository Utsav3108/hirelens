import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                Center(child: Text("Hirelens", style: TextStyle(fontSize: 18))),
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
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("Not having account? Register here."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
