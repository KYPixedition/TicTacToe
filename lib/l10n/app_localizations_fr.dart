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
}
