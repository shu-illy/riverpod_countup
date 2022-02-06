import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((ref) {
  return 'Riverpod Demo Page';
});
final descriptionProvider = Provider<String>((ref) => 'hogehogehoge');
