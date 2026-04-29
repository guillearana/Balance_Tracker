import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_eu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('eu'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'BalanceTracker'**
  String get appTitle;

  /// No description provided for @hello.
  ///
  /// In es, this message translates to:
  /// **'Hola'**
  String get hello;

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres cerrar sesión?'**
  String get signOutConfirm;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @changeLanguage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar idioma'**
  String get changeLanguage;

  /// No description provided for @balance.
  ///
  /// In es, this message translates to:
  /// **'Balance del mes'**
  String get balance;

  /// No description provided for @showMore.
  ///
  /// In es, this message translates to:
  /// **'Mostrar más'**
  String get showMore;

  /// No description provided for @latestTransactions.
  ///
  /// In es, this message translates to:
  /// **'Últimas transacciones'**
  String get latestTransactions;

  /// No description provided for @upcomingPayments.
  ///
  /// In es, this message translates to:
  /// **'Próximos pagos'**
  String get upcomingPayments;

  /// No description provided for @noTransactions.
  ///
  /// In es, this message translates to:
  /// **'No hay transacciones aún'**
  String get noTransactions;

  /// No description provided for @noPayments.
  ///
  /// In es, this message translates to:
  /// **'No hay pagos próximos'**
  String get noPayments;

  /// No description provided for @income.
  ///
  /// In es, this message translates to:
  /// **'Ingreso'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In es, this message translates to:
  /// **'Gasto'**
  String get expense;

  /// No description provided for @daysLeft.
  ///
  /// In es, this message translates to:
  /// **'En {days} días'**
  String daysLeft(int days);

  /// No description provided for @appSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Controla tus finanzas personales'**
  String get appSubtitle;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @enterEmail.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu email'**
  String get enterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Email no válido'**
  String get invalidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu contraseña'**
  String get enterPassword;

  /// No description provided for @minChars.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get minChars;

  /// No description provided for @noAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? '**
  String get noAccount;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get register;

  /// No description provided for @errorDefault.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error. Inténtalo de nuevo.'**
  String get errorDefault;

  /// No description provided for @errorUserNotFound.
  ///
  /// In es, this message translates to:
  /// **'No existe ninguna cuenta con este email.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña incorrecta.'**
  String get errorWrongPassword;

  /// No description provided for @errorUserDisabled.
  ///
  /// In es, this message translates to:
  /// **'Esta cuenta ha sido desactivada.'**
  String get errorUserDisabled;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In es, this message translates to:
  /// **'Email o contraseña incorrectos.'**
  String get errorInvalidCredential;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'eu'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'eu':
      return AppLocalizationsEu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
