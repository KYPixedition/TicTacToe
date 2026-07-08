/// Base type for application-level errors.
sealed class AppError {
  const AppError();
}

/// An unexpected error with no specific classification.
final class UnexpectedError extends AppError {
  const UnexpectedError();
}

/// An error occurred while reading from local storage.
final class StorageReadError extends AppError {
  const StorageReadError();
}

/// An error occurred while writing to local storage.
final class StorageWriteError extends AppError {
  const StorageWriteError();
}

/// Saved game data could not be parsed or validated.
final class InvalidSavedGameError extends AppError {
  const InvalidSavedGameError();
}

/// Player attempted an invalid move.
final class InvalidMoveError extends AppError {
  const InvalidMoveError();
}
