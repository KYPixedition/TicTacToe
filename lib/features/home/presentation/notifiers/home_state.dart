import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

/// UI state for the home screen.
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    required bool isResumeEnabled,
  }) = _HomeState;
}
