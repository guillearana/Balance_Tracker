import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider que expone y gestiona el símbolo de moneda seleccionado por el usuario.
///
/// El estado es un [String] con el símbolo de moneda (ej. `'€'`, `'$'`).
/// El valor se persiste en [SharedPreferences] bajo la clave `'currency'`.
final currencyNotifierProvider =
    StateNotifierProvider<CurrencyNotifier, String>(
      (ref) => CurrencyNotifier(),
    );

/// Notifier que gestiona la moneda activa de la aplicación.
///
/// Estado inicial: `'€'`. Carga el valor persistido al construirse.
class CurrencyNotifier extends StateNotifier<String> {
  CurrencyNotifier() : super('€') {
    _load();
  }

  /// Carga el símbolo de moneda almacenado en [SharedPreferences].
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('currency') ?? '€';
  }

  /// Actualiza el símbolo de moneda a [currency] y lo persiste.
  Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    state = currency;
    await prefs.setString('currency', currency);
  }
}
