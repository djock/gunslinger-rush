import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client_service.g.dart';

@Riverpod(keepAlive: true)
class SupabaseClientService extends _$SupabaseClientService {
  @override
  SupabaseClient build() {
    return Supabase.instance.client;
  }
}
