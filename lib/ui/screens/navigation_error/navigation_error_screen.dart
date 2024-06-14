import 'package:flutter/material.dart';

class NavigationErrorScreen extends StatelessWidget {
  final bool title;
  final String? errorText;
  const NavigationErrorScreen({
    super.key,
    this.errorText,
    this.title = true,
  });

  @override
  Widget build(BuildContext context) {
    String error = title ? 'Произошла ошибка навигации.' : '';
    error += errorText == null ? '' : '\n$errorText';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () {
                    final canPop = Navigator.of(context).canPop();
                    if (canPop) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Назад'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
