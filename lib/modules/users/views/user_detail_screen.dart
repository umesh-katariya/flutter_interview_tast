import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../users/viewmodels/user_viewmodel.dart';

class UserDetailScreen extends ConsumerWidget {
  final String userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userVM = ref.watch(userViewModelProvider);
    final user = userVM.getUserById(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.userDetails ?? "User Details"),
      ),
      body: user == null
          ? const Center(child: Text('User not found'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👤 ${user.name}", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Text("📧 Email: ${user.email}"),
                  Text("📍 Address: ${user.city}"),
                  // Add more fields as per your model
                ],
              ),
            ),
    );
  }
}
