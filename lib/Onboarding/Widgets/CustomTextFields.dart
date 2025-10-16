import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final bool isSecure;

  const CustomTextField({required this.placeholder, this.isSecure = false});

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isSecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
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

        // 👇 Add eye icon when it's a secure field
        suffixIcon: widget.isSecure
            ? IconButton(
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
              )
            : null,
      ),
    );
  }
}
