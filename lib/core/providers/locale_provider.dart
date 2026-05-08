import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider que expone y gestiona el idioma activo de la aplicación.
///
/// El estado es un [Locale]. El valor se persiste en [SharedPreferences]
/// bajo la clave `'locale'`.
final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

/// Notifier que gestiona el [Locale] activo de la aplicación.
///
/// Estado inicial: `Locale('es')`. Carga el valor persistido al construirse.
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('es')) {
    _load();
  }

  /// Carga el código de idioma almacenado en [SharedPreferences].
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale') ?? 'es';
    state = Locale(code);
  }

  /// Actualiza el idioma a [locale] y persiste su código de idioma.
  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    state = locale;
    await prefs.setString('locale', locale.languageCode);
  }
}
