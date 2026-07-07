// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get homeTitle => 'Tic Tac Toe';

  @override
  String get homeNewGame => 'Nouvelle partie';

  @override
  String get homeResumeGame => 'Reprendre la partie';

  @override
  String get gameBackToHome => 'Menu principal';

  @override
  String get gameEntryModeNew => 'Nouvelle partie';

  @override
  String get gameEntryModeResume => 'Reprise de partie';

  @override
  String get gameStatusPlaying => 'En cours';

  @override
  String get gameStatusCpuThinking => 'L\'ordinateur réfléchit…';

  @override
  String get gameStatusPlayerWon => 'Victoire du joueur';

  @override
  String get gameStatusCpuWon => 'Victoire de l\'ordinateur';

  @override
  String get gameStatusDraw => 'Égalité';

  @override
  String get gamePlayerHuman => 'Joueur';

  @override
  String get gamePlayerCpu => 'Ordinateur';
}
