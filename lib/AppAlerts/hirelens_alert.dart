import 'package:flutter/material.dart';

class HirelensAlert {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required List<AlertAction> actions,
  }) {
    if (actions.isEmpty) {
      actions = [
        AlertAction(
          title: 'Close',
          onPressed: () {
            // Cancel action
          },
        ),
      ];
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Message
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // Action Buttons
                ...actions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final action = entry.value;
                  final isLast = index == actions.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          action.onPressed();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: action.isPrimary
                              ? Colors.white
                              : Colors.transparent,
                          foregroundColor: action.isPrimary
                              ? Colors.black
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: action.isPrimary
                                ? BorderSide.none
                                : BorderSide(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          action.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: action.isPrimary
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AlertAction {
  final String title;
  final VoidCallback onPressed;
  final bool isPrimary;

  AlertAction({
    required this.title,
    required this.onPressed,
    this.isPrimary = false,
  });
}
