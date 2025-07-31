import 'package:flutter_interview_tast/core/extension/list_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserViewModelState>(
  (ref) => UserViewModel(ref.watch(userRepositoryProvider)),
);

class UserViewModel extends StateNotifier<UserViewModelState> {
  final UserRepository _repo;
  UserViewModel(this._repo, {bool loadOnInit = true}) : super(UserViewModelState.initial()) {
    if (loadOnInit) loadUsers();
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repo.getUsers();

    if (result.isSuccess) {
      state = state.copyWith(users: result.data!, filteredUsers: result.data!, isLoading: false, errorMessage: null);
    } else {
      state = state.copyWith(users: [], isLoading: false, errorMessage: result.error);
    }
  }

  void searchUser(String query) {
    final results = state.users.where((u) => u.name.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(filteredUsers: results);
  }
}

class UserViewModelState {
  final List<UserModel> users;
  final List<UserModel> filteredUsers;
  final bool isLoading;
  final String? errorMessage;

  UserViewModelState({
    required this.users,
    required this.filteredUsers,
    required this.isLoading,
    this.errorMessage,
  });

  factory UserViewModelState.initial() => UserViewModelState(users: [], filteredUsers: [], isLoading: false);

  UserViewModelState copyWith({
    List<UserModel>? users,
    List<UserModel>? filteredUsers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserViewModelState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  UserModel? getUserById(String id) {
    return users.firstWhereOrNull((user) => user.id.toString() == id);
  }
}
