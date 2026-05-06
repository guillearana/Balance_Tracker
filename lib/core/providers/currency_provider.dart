import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currencyNotifierProvider =
    StateNotifierProvider<CurrencyNotifier, String>(
      (ref) => CurrencyNotifier(),
    );

class CurrencyNotifier extends StateNotifier<String> {
  CurrencyNotifier() : super('€') {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('currency') ?? '€';
  }

  Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    state = currency;
    await prefs.setString('currency', currency);
  }
}
