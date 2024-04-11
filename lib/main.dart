import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gunslinger_rush/config.dart';
import 'package:gunslinger_rush/game.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

int ntpOffset = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final startDate = DateTime.now().toLocal();
  ntpOffset = await NTP.getNtpOffset(localTime: startDate);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
    realtimeClientOptions: const RealtimeClientOptions(eventsPerSecond: 40),
  );

  runApp(
    const ProviderScope(
      child: Game(),
    ),
  );
}
