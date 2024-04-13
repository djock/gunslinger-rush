import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_list_element_service.g.dart';

@riverpod
String getRandomElementFromList(
  GetRandomElementFromListRef ref,
  List<String> list,
) {
  final random = Random();
  return list[random.nextInt(list.length)];
}
