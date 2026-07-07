// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameState {

 Game? get game; AppError? get error; bool get isCpuThinking;
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateCopyWith<GameState> get copyWith => _$GameStateCopyWithImpl<GameState>(this as GameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameState&&(identical(other.game, game) || other.game == game)&&(identical(other.error, error) || other.error == error)&&(identical(other.isCpuThinking, isCpuThinking) || other.isCpuThinking == isCpuThinking));
}


@override
int get hashCode => Object.hash(runtimeType,game,error,isCpuThinking);

@override
String toString() {
  return 'GameState(game: $game, error: $error, isCpuThinking: $isCpuThinking)';
}


}

/// @nodoc
abstract mixin class $GameStateCopyWith<$Res>  {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) _then) = _$GameStateCopyWithImpl;
@useResult
$Res call({
 Game? game, AppError? error, bool isCpuThinking
});


$GameCopyWith<$Res>? get game;

}
/// @nodoc
class _$GameStateCopyWithImpl<$Res>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._self, this._then);

  final GameState _self;
  final $Res Function(GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? game = freezed,Object? error = freezed,Object? isCpuThinking = null,}) {
  return _then(_self.copyWith(
game: freezed == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as Game?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,isCpuThinking: null == isCpuThinking ? _self.isCpuThinking : isCpuThinking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameCopyWith<$Res>? get game {
    if (_self.game == null) {
    return null;
  }

  return $GameCopyWith<$Res>(_self.game!, (value) {
    return _then(_self.copyWith(game: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameState].
extension GameStatePatterns on GameState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameState value)  $default,){
final _that = this;
switch (_that) {
case _GameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameState value)?  $default,){
final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Game? game,  AppError? error,  bool isCpuThinking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.game,_that.error,_that.isCpuThinking);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Game? game,  AppError? error,  bool isCpuThinking)  $default,) {final _that = this;
switch (_that) {
case _GameState():
return $default(_that.game,_that.error,_that.isCpuThinking);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Game? game,  AppError? error,  bool isCpuThinking)?  $default,) {final _that = this;
switch (_that) {
case _GameState() when $default != null:
return $default(_that.game,_that.error,_that.isCpuThinking);case _:
  return null;

}
}

}

/// @nodoc


class _GameState implements GameState {
  const _GameState({this.game, this.error, this.isCpuThinking = false});
  

@override final  Game? game;
@override final  AppError? error;
@override@JsonKey() final  bool isCpuThinking;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateCopyWith<_GameState> get copyWith => __$GameStateCopyWithImpl<_GameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameState&&(identical(other.game, game) || other.game == game)&&(identical(other.error, error) || other.error == error)&&(identical(other.isCpuThinking, isCpuThinking) || other.isCpuThinking == isCpuThinking));
}


@override
int get hashCode => Object.hash(runtimeType,game,error,isCpuThinking);

@override
String toString() {
  return 'GameState(game: $game, error: $error, isCpuThinking: $isCpuThinking)';
}


}

/// @nodoc
abstract mixin class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(_GameState value, $Res Function(_GameState) _then) = __$GameStateCopyWithImpl;
@override @useResult
$Res call({
 Game? game, AppError? error, bool isCpuThinking
});


@override $GameCopyWith<$Res>? get game;

}
/// @nodoc
class __$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(this._self, this._then);

  final _GameState _self;
  final $Res Function(_GameState) _then;

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? game = freezed,Object? error = freezed,Object? isCpuThinking = null,}) {
  return _then(_GameState(
game: freezed == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as Game?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppError?,isCpuThinking: null == isCpuThinking ? _self.isCpuThinking : isCpuThinking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameCopyWith<$Res>? get game {
    if (_self.game == null) {
    return null;
  }

  return $GameCopyWith<$Res>(_self.game!, (value) {
    return _then(_self.copyWith(game: value));
  });
}
}

// dart format on
