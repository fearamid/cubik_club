import 'package:flutter/material.dart';

class NavigationErrorScreen extends StatelessWidget {
  const NavigationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Произошла ошибка навигации.'),
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
    );
  }
}
