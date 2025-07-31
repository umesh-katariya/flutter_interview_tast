import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../../users/views/user_list_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authViewModelProvider.notifier); // only use .read if value won’t change
    final currentLocale = ref.watch(localeProvider);
    final userEmail = auth.currentUserEmail;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.appTitle ?? ""),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) {
              ref.read(localeProvider.notifier).state = locale;
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: const Locale('en'),
                child: Text(
                  'English',
                  style: TextStyle(
                    fontWeight: currentLocale.languageCode == 'en' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              PopupMenuItem(
                value: const Locale('ar'),
                child: Text(
                  'عربي',
                  style: TextStyle(
                    fontWeight: currentLocale.languageCode == 'ar' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              ref.watch(themeProvider) == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              final current = ref.read(themeProvider);
              ref.read(themeProvider.notifier).state = current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          IconButton(
            onPressed: () => auth.logout().then((_) => context.go('/')),
            icon: const Icon(Icons.logout),
            tooltip: AppLocalizations.of(context)?.logout,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userEmail != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '👋 Welcome, $userEmail',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          const Expanded(child: UserListScreen()),
        ],
      ),
    );
  }
}
