import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(authViewModelProvider.notifier);
    final isLoading = ref.watch(authViewModelProvider);

    final emailController = TextEditingController(text: 'test@gmail.com');
    final passwordController = TextEditingController(text: '123456');

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)?.login ?? "")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)?.email),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)?.password),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final result = await vm.loginOrRegister(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (context.mounted) {
                        if (result.success) {
                          context.go('/dashboard');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
                        }
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(AppLocalizations.of(context)?.login ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
