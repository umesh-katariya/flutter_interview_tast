import 'package:flutter_interview_tast/data/api/api_response.dart';
import 'package:flutter_interview_tast/data/models/user_model.dart';
import 'package:flutter_interview_tast/data/repositories/user_repository.dart';
import 'package:flutter_interview_tast/modules/users/viewmodels/user_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ProviderContainer container;
  late MockUserRepository mockRepo;

  setUp(() {
    mockRepo = MockUserRepository();
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockRepo),
        userViewModelProvider.overrideWith((ref) => UserViewModel(mockRepo, loadOnInit: false)),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('loadUsers loads data successfully', () async {
    final mockUsers = [
      UserModel(id: 1, name: 'Umesh', email: 'umesh@example.com', city: 'Ahmedabad'),
      UserModel(id: 2, name: 'Amit', email: 'amit@example.com', city: 'Ahmedabad'),
    ];

    when(() => mockRepo.getUsers()).thenAnswer(
      (_) async => ApiResponse.success(mockUsers),
    );

    final viewModel = container.read(userViewModelProvider.notifier);
    await viewModel.loadUsers();

    final state = container.read(userViewModelProvider);
    expect(state.users, mockUsers);
    expect(state.filteredUsers, mockUsers);
    expect(state.isLoading, false);
    expect(state.errorMessage, isNull);
  });

  test('loadUsers handles API error', () async {
    when(() => mockRepo.getUsers()).thenAnswer(
      (_) async => ApiResponse.error("API error"),
    );

    final viewModel = container.read(userViewModelProvider.notifier);
    await viewModel.loadUsers();

    final state = container.read(userViewModelProvider);
    expect(state.users, isEmpty);
    expect(state.filteredUsers, isEmpty);
    expect(state.isLoading, false);
    expect(state.errorMessage, isNotNull);
  });

  test('searchUser filters correctly', () async {
    final mockUsers = [
      UserModel(id: 1, name: 'Umesh', email: 'umesh@example.com', city: 'Ahmedabad'),
      UserModel(id: 2, name: 'Amit', email: 'amit@example.com', city: 'Ahmedabad'),
    ];

    when(() => mockRepo.getUsers()).thenAnswer(
      (_) async => ApiResponse.success(mockUsers),
    );

    final viewModel = container.read(userViewModelProvider.notifier);
    await viewModel.loadUsers();
    viewModel.searchUser('ume');

    final state = container.read(userViewModelProvider);
    expect(state.filteredUsers.length, 1);
    expect(state.filteredUsers.first.name, 'Umesh');
  });

  test('getUserById returns correct user', () async {
    final mockUsers = [
      UserModel(id: 1, name: 'Umesh', email: 'umesh@example.com', city: 'Ahmedabad'),
      UserModel(id: 2, name: 'Amit', email: 'amit@example.com', city: 'Ahmedabad'),
    ];

    when(() => mockRepo.getUsers()).thenAnswer(
      (_) async => ApiResponse.success(mockUsers),
    );

    final viewModel = container.read(userViewModelProvider.notifier);
    await viewModel.loadUsers();

    final user = viewModel.state.getUserById('2');
    expect(user?.name, 'Amit');
  });
}
