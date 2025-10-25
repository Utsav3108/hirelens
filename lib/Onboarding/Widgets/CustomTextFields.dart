import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final bool isSecure;
  final TextInputType keyboardType;
  final bool enableVerification;
  final bool Function(String)? validator; // returns true if valid
  final bool isSelection;
  final TextEditingController controller;
  final bool hasError;

  /// Optional popup menu items (only used if isSelection = true)
  final List<String>? menuItems;

  /// Optional callback when a menu item is selected
  final void Function(String)? onMenuItemSelected;

  final void Function(String)? onValueChange;

  const CustomTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.isSecure = false,
    this.keyboardType = TextInputType.text,
    this.enableVerification = false,
    this.validator,
    this.isSelection = false,
    this.menuItems,
    this.onMenuItemSelected,
    this.onValueChange,
    this.hasError = false,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool _isValid = false;
  late final TextEditingController _controller = widget.controller;
  final FocusNode _focusNode = FocusNode();

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
    _focusNode.dispose();
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

  Future<void> _showPopupMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selectedValue = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(position, position),
        Offset.zero & overlay.size,
      ),
      items:
          widget.menuItems?.map((item) {
            return PopupMenuItem<String>(value: item, child: Text(item));
          }).toList() ??
          [],
    );

    if (selectedValue != null) {
      _controller.text = selectedValue;

      widget.onMenuItemSelected?.call(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        if (widget.isSelection) {
          _focusNode.unfocus();
          await _showPopupMenu(context, details.globalPosition);
        } else {
          _focusNode.requestFocus();
        }
      },
      child: AbsorbPointer(
        absorbing: widget.isSelection,
        child: TextField(
          onChanged: widget.onValueChange,
          textInputAction: TextInputAction.done,
          controller: _controller,
          focusNode: _focusNode,
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
              borderSide: BorderSide(
                color: widget.hasError ? Colors.red : Colors.white24,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: widget.hasError ? Colors.red : Colors.white,
                width: 1.5,
              ),
            ),
            suffixIcon: _buildSuffixIcon(),
          ),
        ),
      ),
    );
  }
}
