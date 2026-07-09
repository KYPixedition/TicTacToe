import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/core/hooks/use_on_route_visible.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/core/widgets/app_gradient_background.dart';
import 'package:tictactoe/features/game/domain/entities/difficulty.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_notifier.dart';
import 'package:tictactoe/features/home/presentation/widgets/difficulty_selection_dialog.dart';
import 'package:tictactoe/features/home/presentation/widgets/home_logo.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  static const double _buttonMinWidth = 260;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useOnRouteVisible(
      () => ref.read(homeNotifierProvider.notifier).refreshResumeAvailability(),
    );

    final state = ref.watch(homeNotifierProvider);
    final l10n = AppLocalizations.of(context);
    final spacings = context.spacings;
    final isResumeEnabled = state.isResumeEnabled;

    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: spacings.paddingL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                spacings.gapVerticalL,
                HomeLogo(semanticsLabel: l10n?.homeTitle ?? ''),
                const Spacer(),
                AppButton.primary(
                  onPressed: () async {
                    final difficulty = await showDialog<Difficulty>(
                      context: context,
                      builder: (context) => const DifficultySelectionDialog(),
                    );
                    if (!context.mounted || difficulty == null) {
                      return;
                    }
                    ref
                        .read(homeNotifierProvider.notifier)
                        .openNewGame(difficulty: difficulty);
                  },
                  label: l10n?.homeNewGame ?? '',
                  icon: Icons.add_circle_outlined,
                  minWidth: _buttonMinWidth,
                ),
                if (isResumeEnabled) ...[
                  spacings.gapVerticalL,
                  AppButton.secondary(
                    onPressed: () => ref
                        .read(homeNotifierProvider.notifier)
                        .openResumeGame(),
                    label: l10n?.homeResumeGame ?? '',
                    icon: Icons.play_arrow_sharp,
                    minWidth: _buttonMinWidth,
                  ),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
