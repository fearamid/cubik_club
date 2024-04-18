import 'package:flutter/material.dart';

abstract class CCHelperFunctions {
  static void showSnackBar({
    required BuildContext context,
    String? message,
    String replaceMessage = '',
  }) {
    String text = replaceMessage;
    if (message != null && message.isNotEmpty) {
      text = message;
    }

    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(text),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAllert({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Назад',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        );
      },
    );
  }

  // static void navigateToScreen(BuildContext context, Widget screen) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => screen),
  //   );
  // }

  // static String truncateText(String text, int maxLenght) {
  //   if (text.length <= maxLenght) {
  //     return text;
  //   } else {
  //     return '${text.substring(0, maxLenght)}...';
  //   }
  // }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
