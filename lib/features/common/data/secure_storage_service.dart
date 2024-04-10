import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

@riverpod
class SecureStorageService extends _$SecureStorageService {
  @override
  FlutterSecureStorage build() {
    return const FlutterSecureStorage();
  }
}
