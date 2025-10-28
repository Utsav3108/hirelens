import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final String text;
  final double height;

  const SignInWithGoogleButton({
    Key? key,
    this.onPressed,
    this.text = 'Sign in with Google',
    this.height = 48.0,
  }) : super(key: key);

  @override
  State<SignInWithGoogleButton> createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  bool _loading = false;

  void _handleTap() async {
    if (widget.onPressed == null) return;
    setState(() => _loading = true);
    try {
      await widget.onPressed!();
    } catch (e) {
      // Optional: surface error with snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign-in failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: OutlinedButton(
        onPressed: _loading ? null : _handleTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/search.png',
                      height: 20,
                      width: 20,
                    ),
                  ),

            const SizedBox(width: 12),
            Text(widget.text, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
