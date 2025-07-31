import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/common_error_view.dart';
import '../../../core/widgets/common_loading_view.dart';
import '../viewmodels/user_viewmodel.dart';
import 'user_item_view.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(userViewModelProvider);
    final controller = ref.read(userViewModelProvider.notifier);

    if (vm.isLoading) {
      return const CommonLoadingView();
    } else if (vm.errorMessage != null) {
      return CommonErrorView(message: vm.errorMessage!);
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.searchUser,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: controller.searchUser,
            ),
          ),
          Expanded(
            child: vm.filteredUsers.isEmpty
                ? CommonErrorView(message: AppLocalizations.of(context)?.noDataFound ?? "")
                : ListView.builder(
                    itemCount: vm.filteredUsers.length,
                    itemBuilder: (_, index) {
                      final user = vm.filteredUsers[index];
                      return UserItemView(
                        user: user,
                        onTap: () => context.push('/user/${user.id}'),
                      );
                    },
                  ),
          ),
        ],
      );
    }
  }
}
