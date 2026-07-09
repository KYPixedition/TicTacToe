import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tictactoe/app/app.dart';
import 'package:tictactoe/core/providers/app_startup_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(appStartupProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: DevicePreview(
        enabled: kDebugMode,
        builder: (context) => const App(),
      ),
    ),
  );
}
