import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker/talker.dart';

part 'talker_provider.g.dart';

/// Provides the application [Talker] logger instance.
@riverpod
Talker talker(Ref ref) => Talker();
