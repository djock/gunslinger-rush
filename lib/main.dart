import 'package:flutter/material.dart';
import 'package:gunslinger_rush/config.dart';
import 'package:gunslinger_rush/lobby_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
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
