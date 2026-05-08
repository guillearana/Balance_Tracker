import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:balance_tracker/core/providers/currency_provider.dart';

/// Formatea [amount] con el símbolo de moneda activo obtenido de
/// [currencyNotifierProvider], usando el locale `es_ES` como separadores.
String formatCurrency(WidgetRef ref, double amount) {
  final symbol = ref.watch(currencyNotifierProvider);
  return NumberFormat.currency(locale: 'es_ES', symbol: symbol).format(amount);
}
