import 'package:flutter/material.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';

class CategoryTranslator {
  static final Map<String, String Function(AppLocalizations)> _map = {
    'Comida': (l) => l.cat_comida,
    'Transporte': (l) => l.cat_transporte,
    'Ocio': (l) => l.cat_ocio,
    'Salud': (l) => l.cat_salud,
    'Hogar': (l) => l.cat_hogar,
    'Ropa': (l) => l.cat_ropa,
    'Educacion': (l) => l.cat_educacion,
    'Educación': (l) => l.cat_educacion,
    'Otros': (l) => l.cat_otros,
    'Sueldo': (l) => l.cat_sueldo,
    'Freelance': (l) => l.cat_freelance,
    'Inversiones': (l) => l.cat_inversiones,
    'Regalos': (l) => l.cat_regalos,
    'Suscripciones': (l) => l.cat_suscripciones,
    'Vivienda': (l) => l.cat_vivienda,
  };

  static String translate(BuildContext context, String name) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return name;
    final getter = _map[name];
    return getter != null ? getter(l10n) : name;
  }
}
