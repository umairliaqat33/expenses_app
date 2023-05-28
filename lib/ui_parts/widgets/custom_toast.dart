import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class CustomToast {
  static void showCustomToast(String text, BuildContext context) {
    showToast(
      text,
      context: context,
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 2),
      position: const StyledToastPosition(
        align: Alignment.bottomCenter,
        offset: 60,
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      textPadding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 24,
        right: 24,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          100,
        ),
      ),
    );
  }
}
