import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_service.g.dart';

@riverpod
class LoggerService extends _$LoggerService {
  @override
  Logger build() {
    return Logger();
  }
}
