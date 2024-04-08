import 'package:flutter/material.dart';
import 'package:gunslinger_rush/config.dart';
import 'package:gunslinger_rush/lobby_screen.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

int ntpOffset = 0;

void main() async {
  DateTime startDate = new DateTime.now().toLocal();
  ntpOffset = await NTP.getNtpOffset(localTime: startDate);

  print(
      'NTP DateTime offset align: ${startDate.add(new Duration(milliseconds: ntpOffset))}');

  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
    realtimeClientOptions: const RealtimeClientOptions(eventsPerSecond: 40),
  );
  runApp(MaterialApp(
    title: 'Gunslinger Rush',
    debugShowCheckedModeBanner: false,
    home: LobbyScreen(),
  ));
}
