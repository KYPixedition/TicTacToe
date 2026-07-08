/// Difficulty level used by the CPU strategy for a game.
enum Difficulty {
  /// Gives the player more opportunities by choosing the weakest Minimax move.
  easy,

  /// Balances challenge by choosing a neutral Minimax move when possible.
  medium,

  /// Plays optimally by choosing the strongest Minimax move.
  hard,
}
