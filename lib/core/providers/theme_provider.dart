import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider que expone y gestiona el modo de tema de la aplicación.
///
/// El estado es un [ThemeMode]. El valor se persiste en [SharedPreferences]
/// bajo la clave `'isDarkMode'`.
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

/// Notifier que gestiona el [ThemeMode] activo de la aplicación.
///
/// Estado inicial: [ThemeMode.light]. Carga el valor persistido al construirse;
/// si no hay valor guardado, aplica el modo oscuro por defecto.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  /// Carga el modo de tema almacenado en [SharedPreferences].
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? true; // ← true por defecto
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Alterna entre [ThemeMode.light] y [ThemeMode.dark] y persiste la elección.
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      await prefs.setBool('isDarkMode', true);
    } else {
      state = ThemeMode.light;
      await prefs.setBool('isDarkMode', false);
    }
  }
}
