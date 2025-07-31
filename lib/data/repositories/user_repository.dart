import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/app_constants.dart';
import '../api/api_end_points.dart';
import '../api/api_handler.dart';
import '../api/api_response.dart';
import '../database/drift_database.dart';
import '../models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository(AppDatabase()));

class UserRepository {
  final AppDatabase db;
  UserRepository(this.db);

  Future<ApiResponse<List<UserModel>>> getUsers() async {
    try {
      final response = await ApiHandler.call(
        type: ApiType.get,
        apiEndPoint: ApiEndPoints.getUsers,
        mapHeaders: AppConstants.commonJsonRequestHeader(),
      );

      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<UserModel> users = jsonList
          .map((e) => UserModel(
                id: e['id'],
                name: e['name'],
                email: e['email'],
                city: e['address']['city'],
              ))
          .toList();

      // Cache users
      for (var user in users) {
        await db.into(db.users).insertOnConflictUpdate(UsersCompanion(
              id: Value(user.id),
              name: Value(user.name),
              email: Value(user.email),
              city: Value(user.city),
            ));
      }

      return ApiResponse.success(users);
    } catch (e) {
      final cachedUsers = await _getCachedUsers();
      if (cachedUsers.isNotEmpty) {
        return ApiResponse.success(cachedUsers);
      }
      return ApiResponse.error(e.toString());
    }
  }

  Future<List<UserModel>> _getCachedUsers() async {
    final rows = await db.select(db.users).get();
    return rows.map((e) => UserModel(id: e.id, name: e.name, email: e.email, city: e.city)).toList();
  }
}
