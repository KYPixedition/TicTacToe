import 'package:tictactoe/core/error/app_error.dart';

/// Represents the outcome of an operation that can succeed or fail.
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;

  const factory Result.failure(AppError error) = Failure<T>;
}

/// Successful result carrying a [value].
final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

/// Failed result carrying an [error].
final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppError error;
}
