// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get appTitle => 'BalanceTracker';

  @override
  String get hello => 'Kaixo';

  @override
  String get signOut => 'Saioa itxi';

  @override
  String get signOutConfirm => 'Ziur zaude saioa itxi nahi duzula?';

  @override
  String get cancel => 'Utzi';

  @override
  String get changeLanguage => 'Hizkuntza aldatu';

  @override
  String get balance => 'Hileko saldoa';

  @override
  String get showMore => 'Gehiago ikusi';

  @override
  String get latestTransactions => 'Azken transakzioak';

  @override
  String get upcomingPayments => 'Datozen ordainketak';

  @override
  String get noTransactions => 'Oraindik transakziorik ez';

  @override
  String get noPayments => 'Ez dago ordainketarik';

  @override
  String get income => 'Sarrera';

  @override
  String get expense => 'Gastua';

  @override
  String daysLeft(int days) {
    return '$days egunetan';
  }

  @override
  String get appSubtitle => 'Kontrolatu zure finantza pertsonalak';

  @override
  String get login => 'Saioa hasi';

  @override
  String get email => 'Emaila';

  @override
  String get password => 'Pasahitza';

  @override
  String get enterEmail => 'Sartu zure emaila';

  @override
  String get invalidEmail => 'Emaila ez da baliozkoa';

  @override
  String get enterPassword => 'Sartu zure pasahitza';

  @override
  String get minChars => 'Gutxienez 6 karaktere';

  @override
  String get noAccount => 'Ez duzu konturik? ';

  @override
  String get register => 'Erregistratu';

  @override
  String get errorDefault => 'Errore bat gertatu da. Saiatu berriro.';

  @override
  String get errorUserNotFound => 'Ez dago konturik email honekin.';

  @override
  String get errorWrongPassword => 'Pasahitz okerra.';

  @override
  String get errorUserDisabled => 'Kontu hau desgaituta dago.';

  @override
  String get errorInvalidCredential => 'Email edo pasahitz okerra.';
}
