import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

snackBarDialog({required BuildContext context, required String title, required String message, required bool isSuccess}) {
  return AnimatedSnackBar.rectangle(
    title,
    message,
    type: isSuccess ? AnimatedSnackBarType.success : AnimatedSnackBarType.error,
    brightness: Brightness.light,
  ).show(
    context,
  );
}