import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/core/hooks/use_on_route_visible.dart';
import 'package:tictactoe/core/theme/app_theme_context.dart';
import 'package:tictactoe/core/widgets/app_button.dart';
import 'package:tictactoe/features/home/presentation/notifiers/home_notifier.dart';
import 'package:tictactoe/features/home/presentation/widgets/home_logo.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

/// Home screen with new game and resume actions.
class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  static const double _buttonMinWidth = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useOnRouteVisible(
      () => ref.read(homeNotifierProvider.notifier).refreshResumeAvailability(),
    );

    final state = ref.watch(homeNotifierProvider);
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final spacings = context.spacings;
    final isResumeEnabled = state.isResumeEnabled;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: spacings.paddingL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: HomeLogo(semanticsLabel: l10n?.homeTitle ?? ''),
              ),
              spacings.gapVerticalXl,
              AppButton.primary(
                onPressed: () =>
                    ref.read(homeNotifierProvider.notifier).openNewGame(),
                label: l10n?.homeNewGame ?? '',
                icon: Icons.play_arrow_rounded,
                minWidth: _buttonMinWidth,
              ),
              spacings.gapVerticalL,
              AppButton.secondary(
                onPressed: isResumeEnabled
                    ? () => ref
                          .read(homeNotifierProvider.notifier)
                          .openResumeGame()
                    : null,
                label: l10n?.homeResumeGame ?? '',
                icon: Icons.replay_rounded,
                minWidth: _buttonMinWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
