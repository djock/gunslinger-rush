import 'package:gunslinger_rush/common/data_source/supabase_client_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_channel_service.g.dart';

@Riverpod(keepAlive: true)
class SupabaseChannelService extends _$SupabaseChannelService {
  @override
  RealtimeChannel build(String channelName) {
    final supabaseClient = ref.read(supabaseClientServiceProvider);

    final channel = supabaseClient.channel(
      channelName,
      opts: const RealtimeChannelConfig(self: true),
    );

    return channel;
  }
}
