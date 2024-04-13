import 'dart:convert';

import 'package:gunslinger_rush/common/data/logger_service.dart';
import 'package:gunslinger_rush/common/data/secure_storage_service.dart';
import 'package:gunslinger_rush/common/domain/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'welcome_screen_service.g.dart';

@riverpod
class WelcomeScreenService extends _$WelcomeScreenService {
  @override
  Future<Player?> build() {
    return _getUser();
  }

  Future<Player?> _getUser() async {
    final secureStorage = ref.read(secureStorageServiceProvider);

    if (await secureStorage.containsKey(key: 'user')) {
      final userJson = await secureStorage.read(key: 'user');

      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final user = Player.fromJson(userMap);

      ref.read(loggerServiceProvider).i('User loaded: $user');

      return user;
    }

    ref.read(loggerServiceProvider).i('User not found!');

    return null;
  }

  Future<Player> savePlayer(String name) async {
    final player = Player(id: const Uuid().v4(), name: name);

    final secureStorage = ref.read(secureStorageServiceProvider);
    final playerJson = jsonEncode(player.toJson());
    await secureStorage.write(key: 'user', value: playerJson);

    return player;
  }
}
