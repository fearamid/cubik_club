import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('loader', (route) => false);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Домашний экран'),
            ElevatedButton(
              onPressed: () => viewModel.onLogoutButtonPressed(context),
              child: const Text('Выход'),
            )
          ],
        ),
      ),
    );
  }
}
