import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final bool isSecure;
  final TextInputType keyboardType;
  final bool enableVerification;
  final bool Function(String)? validator; // returns true if valid

  const CustomTextField({
    super.key,
    required this.placeholder,
    this.isSecure = false,
    this.keyboardType = TextInputType.text,
    this.enableVerification = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool _isValid = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isSecure;

    // Add listener for validation if enabled
    if (widget.enableVerification && widget.validator != null) {
      _controller.addListener(() {
        final valid = widget.validator!(_controller.text);
        if (valid != _isValid) {
          setState(() => _isValid = valid);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget? _buildSuffixIcon() {
    if (widget.enableVerification && widget.validator != null) {
      if (_isValid) {
        return const Icon(
          Icons.check_circle,
          color: Colors.greenAccent,
          size: 20,
        );
      }
    }

    if (widget.isSecure) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.white70,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white24, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }
}
