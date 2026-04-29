import 'package:balance_tracker/core/providers/locale_provider.dart';
import 'package:balance_tracker/core/router/app_router.dart';
import 'package:balance_tracker/core/theme/app_theme.dart';
import 'package:balance_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting(null, null);
  runApp(
    const ProviderScope(
      child: BalanceTrackerApp(),
    ),
  );
}

class BalanceTrackerApp extends ConsumerWidget {
  const BalanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      title: 'BalanceTracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: locale,
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
        Locale('eu'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}