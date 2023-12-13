import 'package:flutter/material.dart';

enum Toasts { INFO, ERROR, SUCCESS, WARNING }

class ToastCustom {
  const ToastCustom();

  static showToast(
      {bool? isBottom,
      required BuildContext context,
      required String content,
      required Toasts status}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        margin: isBottom != null
            ? isBottom
                ? null
                : EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 150,
                    left: 10,
                    right: 10)
            : EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 10,
                right: 10),
        duration: const Duration(seconds: 1),
        backgroundColor: ToastCustom.getColor(status),
        content: Text(content,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }

  static Color getColor(Toasts status) {
    switch (status) {
      case Toasts.INFO:
        return Colors.blue;

      case Toasts.ERROR:
        return Colors.red;

      case Toasts.SUCCESS:
        return Colors.green;
      case Toasts.WARNING:
        return Colors.orange;
    }
  }
}
