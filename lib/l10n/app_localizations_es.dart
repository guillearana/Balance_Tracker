// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'BalanceTracker';

  @override
  String get hello => 'Hola';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutConfirm => '¿Seguro que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get balance => 'Balance del mes';

  @override
  String get showMore => 'Mostrar más';

  @override
  String get latestTransactions => 'Últimas transacciones';

  @override
  String get upcomingPayments => 'Próximos pagos';

  @override
  String get noTransactions => 'No hay transacciones aún';

  @override
  String get noPayments => 'No hay pagos próximos';

  @override
  String get income => 'Ingreso';

  @override
  String get expense => 'Gasto';

  @override
  String daysLeft(int days) {
    return 'En $days días';
  }

  @override
  String get appSubtitle => 'Controla tus finanzas personales';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get email => 'Email';

  @override
  String get password => 'Contraseña';

  @override
  String get enterEmail => 'Introduce tu email';

  @override
  String get invalidEmail => 'Email no válido';

  @override
  String get enterPassword => 'Introduce tu contraseña';

  @override
  String get minChars => 'Mínimo 6 caracteres';

  @override
  String get noAccount => '¿No tienes cuenta? ';

  @override
  String get register => 'Regístrate';

  @override
  String get errorDefault => 'Ha ocurrido un error. Inténtalo de nuevo.';

  @override
  String get errorUserNotFound => 'No existe ninguna cuenta con este email.';

  @override
  String get errorWrongPassword => 'Contraseña incorrecta.';

  @override
  String get errorUserDisabled => 'Esta cuenta ha sido desactivada.';

  @override
  String get errorInvalidCredential => 'Email o contraseña incorrectos.';
}
