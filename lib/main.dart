import 'package:flutter/material.dart';
import 'package:hirelens/Home/home.dart';
import 'package:hirelens/Onboarding/login.dart';
import 'package:hirelens/Onboarding/registration.dart';
import 'package:hirelens/auth_wrapper.dart'; // Import the auth wrapper

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HireLens',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // Use AuthWrapper as initial route
      home: const AuthWrapper(),

      // Define named routes
      routes: {
        '/login': (context) => const Login(title: 'Login'),
        '/register': (context) => const Register(),
        '/home': (context) => const Home(),
      },
    );
  }
}

// ============================================
// EXAMPLE: How to implement logout in your Home screen
// ============================================

/*
import 'package:firebase_auth/firebase_auth.dart';

// In your Home widget, add this logout method:
Future<void> _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigation is handled automatically by AuthWrapper
    // But if you want to explicitly navigate:
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
  } catch (e) {
    print('Error signing out: $e');
  }
}

// Use it in a button:
ElevatedButton(
  onPressed: () => _logout(context),
  child: const Text('Logout'),
)
*/

// ============================================
// EXAMPLE: How to navigate after successful login
// ============================================

/*
// In your Login widget, after successful authentication:

Future<void> _login() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // AuthWrapper will automatically redirect to Home
    // Or explicitly navigate:
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => false,
      );
    }
  } catch (e) {
    // Handle error
    print('Login error: $e');
  }
}
*/
