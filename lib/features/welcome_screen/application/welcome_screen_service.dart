import 'dart:convert';

import 'package:gunslinger_rush/features/common/data/logger_service.dart';
import 'package:gunslinger_rush/features/common/data/secure_storage_service.dart';
import 'package:gunslinger_rush/features/common/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'welcome_screen_service.g.dart';

@riverpod
class WelcomeScreenService extends _$WelcomeScreenService {
  @override
  Future<User?> build() {
    return _getUser();
  }

  Future<User?> _getUser() async {
    final secureStorage = ref.read(secureStorageServiceProvider);

    if (await secureStorage.containsKey(key: 'user')) {
      final userJson = await secureStorage.read(key: 'user');

      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = User.fromJson(userMap);

      ref.read(loggerServiceProvider).i('User loaded: $user');

      return user;
    }

    ref.read(loggerServiceProvider).i('User not found!');

    return null;
  }

  Future<void> saveUser(String name) async {
    final user = User(id: const Uuid().v4(), name: name);
    ref.read(loggerServiceProvider).i('saveUser called: $user');

    final secureStorage = ref.read(secureStorageServiceProvider);
    final userJson = jsonEncode(user.toJson());
    await secureStorage.write(key: 'user', value: userJson);
  }
}
