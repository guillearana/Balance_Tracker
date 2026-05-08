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

  /// No description provided for @rememberSession.
  ///
  /// In es, this message translates to:
  /// **'Recordar sesión'**
  String get rememberSession;

  /// No description provided for @navLimits.
  ///
  /// In es, this message translates to:
  /// **'Límites'**
  String get navLimits;

  /// No description provided for @navPayments.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get navPayments;

  /// No description provided for @members.
  ///
  /// In es, this message translates to:
  /// **'Miembros'**
  String get members;

  /// No description provided for @admin.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get admin;

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

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get createAccount;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Empieza a controlar tus finanzas hoy'**
  String get createAccountSubtitle;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu nombre'**
  String get enterName;

  /// No description provided for @confirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get confirmPassword;

  /// No description provided for @confirmYourPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirma tu contraseña'**
  String get confirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsDoNotMatch;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? '**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get signIn;

  /// No description provided for @errorEmailInUse.
  ///
  /// In es, this message translates to:
  /// **'Ya existe una cuenta con este email.'**
  String get errorEmailInUse;

  /// No description provided for @errorWeakPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña es demasiado débil.'**
  String get errorWeakPassword;

  /// No description provided for @transactions.
  ///
  /// In es, this message translates to:
  /// **'Transacciones'**
  String get transactions;

  /// No description provided for @all.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get all;

  /// No description provided for @noTransactionsFound.
  ///
  /// In es, this message translates to:
  /// **'No hay transacciones'**
  String get noTransactionsFound;

  /// No description provided for @noCategory.
  ///
  /// In es, this message translates to:
  /// **'Sin categoría'**
  String get noCategory;

  /// No description provided for @errorLoadingTransactions.
  ///
  /// In es, this message translates to:
  /// **'Error cargando transacciones'**
  String get errorLoadingTransactions;

  /// No description provided for @newTransaction.
  ///
  /// In es, this message translates to:
  /// **'Nueva transacción'**
  String get newTransaction;

  /// No description provided for @selectCategory.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una categoría'**
  String get selectCategory;

  /// No description provided for @enterAmount.
  ///
  /// In es, this message translates to:
  /// **'Introduce una cantidad'**
  String get enterAmount;

  /// No description provided for @invalidAmount.
  ///
  /// In es, this message translates to:
  /// **'Cantidad no válida'**
  String get invalidAmount;

  /// No description provided for @category.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get category;

  /// No description provided for @date.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get date;

  /// No description provided for @noteOptional.
  ///
  /// In es, this message translates to:
  /// **'Nota (opcional)'**
  String get noteOptional;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @errorLoadingCategories.
  ///
  /// In es, this message translates to:
  /// **'Error cargando categorías'**
  String get errorLoadingCategories;

  /// No description provided for @financialControl.
  ///
  /// In es, this message translates to:
  /// **'Control financiero'**
  String get financialControl;

  /// No description provided for @budgets.
  ///
  /// In es, this message translates to:
  /// **'Presupuestos'**
  String get budgets;

  /// No description provided for @debts.
  ///
  /// In es, this message translates to:
  /// **'Deudas'**
  String get debts;

  /// No description provided for @add.
  ///
  /// In es, this message translates to:
  /// **'Añadir'**
  String get add;

  /// No description provided for @noBudgets.
  ///
  /// In es, this message translates to:
  /// **'No hay presupuestos'**
  String get noBudgets;

  /// No description provided for @addBudget.
  ///
  /// In es, this message translates to:
  /// **'Añadir presupuesto'**
  String get addBudget;

  /// No description provided for @newBudget.
  ///
  /// In es, this message translates to:
  /// **'Nuevo presupuesto'**
  String get newBudget;

  /// No description provided for @monthlyLimit.
  ///
  /// In es, this message translates to:
  /// **'Límite mensual'**
  String get monthlyLimit;

  /// No description provided for @limitExceededBy.
  ///
  /// In es, this message translates to:
  /// **'Límite superado por {amount}'**
  String limitExceededBy(String amount);

  /// No description provided for @nearLimitRemaining.
  ///
  /// In es, this message translates to:
  /// **'Cerca del límite — queda {amount}'**
  String nearLimitRemaining(String amount);

  /// No description provided for @spentOf.
  ///
  /// In es, this message translates to:
  /// **'{spent} de {total}'**
  String spentOf(String spent, String total);

  /// No description provided for @completeAllFields.
  ///
  /// In es, this message translates to:
  /// **'Completa todos los campos'**
  String get completeAllFields;

  /// No description provided for @noDebts.
  ///
  /// In es, this message translates to:
  /// **'No hay deudas registradas'**
  String get noDebts;

  /// No description provided for @addDebt.
  ///
  /// In es, this message translates to:
  /// **'Añadir deuda'**
  String get addDebt;

  /// No description provided for @newDebt.
  ///
  /// In es, this message translates to:
  /// **'Nueva deuda'**
  String get newDebt;

  /// No description provided for @totalPending.
  ///
  /// In es, this message translates to:
  /// **'Total pendiente'**
  String get totalPending;

  /// No description provided for @totalAmount.
  ///
  /// In es, this message translates to:
  /// **'Importe total'**
  String get totalAmount;

  /// No description provided for @monthlyPayment.
  ///
  /// In es, this message translates to:
  /// **'Cuota mensual (€)'**
  String get monthlyPayment;

  /// No description provided for @dueDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de vencimiento'**
  String get dueDate;

  /// No description provided for @due.
  ///
  /// In es, this message translates to:
  /// **'Vence: {date}'**
  String due(String date);

  /// No description provided for @ofTotal.
  ///
  /// In es, this message translates to:
  /// **'de {total}'**
  String ofTotal(String total);

  /// No description provided for @installment.
  ///
  /// In es, this message translates to:
  /// **'Cuota: {amount}/mes'**
  String installment(String amount);

  /// No description provided for @markPaid.
  ///
  /// In es, this message translates to:
  /// **'Marcar pagada'**
  String get markPaid;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @deleteDebt.
  ///
  /// In es, this message translates to:
  /// **'Eliminar deuda'**
  String get deleteDebt;

  /// No description provided for @deleteDebtConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar \"{name}\"?'**
  String deleteDebtConfirm(String name);

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesDelete.
  ///
  /// In es, this message translates to:
  /// **'Sí, eliminar'**
  String get yesDelete;

  /// No description provided for @subscriptions.
  ///
  /// In es, this message translates to:
  /// **'Suscripciones'**
  String get subscriptions;

  /// No description provided for @noActiveSubscriptions.
  ///
  /// In es, this message translates to:
  /// **'No hay suscripciones activas'**
  String get noActiveSubscriptions;

  /// No description provided for @addSubscription.
  ///
  /// In es, this message translates to:
  /// **'Añadir suscripción'**
  String get addSubscription;

  /// No description provided for @newSubscription.
  ///
  /// In es, this message translates to:
  /// **'Nueva suscripción'**
  String get newSubscription;

  /// No description provided for @totalMonthlyExpense.
  ///
  /// In es, this message translates to:
  /// **'Gasto mensual total'**
  String get totalMonthlyExpense;

  /// No description provided for @monthly.
  ///
  /// In es, this message translates to:
  /// **'Mensual'**
  String get monthly;

  /// No description provided for @annual.
  ///
  /// In es, this message translates to:
  /// **'Anual'**
  String get annual;

  /// No description provided for @weekly.
  ///
  /// In es, this message translates to:
  /// **'Semanal'**
  String get weekly;

  /// No description provided for @nextIn.
  ///
  /// In es, this message translates to:
  /// **'Próximo en {days} días'**
  String nextIn(int days);

  /// No description provided for @cancelSubscription.
  ///
  /// In es, this message translates to:
  /// **'Cancelar suscripción'**
  String get cancelSubscription;

  /// No description provided for @cancelSubscriptionConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Cancelar \"{name}\"? Dejará de generar cobros.'**
  String cancelSubscriptionConfirm(String name);

  /// No description provided for @yesCancel.
  ///
  /// In es, this message translates to:
  /// **'Sí, cancelar'**
  String get yesCancel;

  /// No description provided for @amount.
  ///
  /// In es, this message translates to:
  /// **'Importe'**
  String get amount;

  /// No description provided for @frequency.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia'**
  String get frequency;

  /// No description provided for @paymentMode.
  ///
  /// In es, this message translates to:
  /// **'Modo de pago'**
  String get paymentMode;

  /// No description provided for @automatic.
  ///
  /// In es, this message translates to:
  /// **'Automático'**
  String get automatic;

  /// No description provided for @manual.
  ///
  /// In es, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @groups.
  ///
  /// In es, this message translates to:
  /// **'Grupos'**
  String get groups;

  /// No description provided for @noGroupsCreated.
  ///
  /// In es, this message translates to:
  /// **'No hay grupos creados'**
  String get noGroupsCreated;

  /// No description provided for @createGroup.
  ///
  /// In es, this message translates to:
  /// **'Crear grupo'**
  String get createGroup;

  /// No description provided for @newGroup.
  ///
  /// In es, this message translates to:
  /// **'Nuevo grupo'**
  String get newGroup;

  /// No description provided for @groupName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del grupo'**
  String get groupName;

  /// No description provided for @enterGroupName.
  ///
  /// In es, this message translates to:
  /// **'Introduce un nombre para el grupo'**
  String get enterGroupName;

  /// No description provided for @deleteGroup.
  ///
  /// In es, this message translates to:
  /// **'Borrar grupo'**
  String get deleteGroup;

  /// No description provided for @deleteGroupConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres borrar \"{name}\"?'**
  String deleteGroupConfirm(String name);

  /// No description provided for @balances.
  ///
  /// In es, this message translates to:
  /// **'Balances'**
  String get balances;

  /// No description provided for @expenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get expenses;

  /// No description provided for @noExpensesYet.
  ///
  /// In es, this message translates to:
  /// **'No hay gastos aún'**
  String get noExpensesYet;

  /// No description provided for @paidBy.
  ///
  /// In es, this message translates to:
  /// **'Pagado por: {name}'**
  String paidBy(String name);

  /// No description provided for @addExpense.
  ///
  /// In es, this message translates to:
  /// **'Añadir gasto'**
  String get addExpense;

  /// No description provided for @description.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// No description provided for @errorLoadingGroups.
  ///
  /// In es, this message translates to:
  /// **'Error cargando grupos'**
  String get errorLoadingGroups;

  /// No description provided for @userNotAuthenticated.
  ///
  /// In es, this message translates to:
  /// **'Usuario no autenticado'**
  String get userNotAuthenticated;

  /// No description provided for @errorLoadingData.
  ///
  /// In es, this message translates to:
  /// **'Error cargando datos'**
  String get errorLoadingData;

  /// No description provided for @analysis.
  ///
  /// In es, this message translates to:
  /// **'Análisis'**
  String get analysis;

  /// No description provided for @incomeVsExpense.
  ///
  /// In es, this message translates to:
  /// **'Ingresos vs Gastos'**
  String get incomeVsExpense;

  /// No description provided for @last6Months.
  ///
  /// In es, this message translates to:
  /// **'Últimos 6 meses'**
  String get last6Months;

  /// No description provided for @expensesByCategory.
  ///
  /// In es, this message translates to:
  /// **'Gastos por categoría'**
  String get expensesByCategory;

  /// No description provided for @noExpensesThisMonth.
  ///
  /// In es, this message translates to:
  /// **'No hay gastos este mes'**
  String get noExpensesThisMonth;

  /// No description provided for @incomes.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get incomes;

  /// No description provided for @memberCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, one{{count} miembro} other{{count} miembros}}'**
  String memberCount(int count);

  /// No description provided for @cat_comida.
  ///
  /// In es, this message translates to:
  /// **'Comida'**
  String get cat_comida;

  /// No description provided for @cat_transporte.
  ///
  /// In es, this message translates to:
  /// **'Transporte'**
  String get cat_transporte;

  /// No description provided for @cat_ocio.
  ///
  /// In es, this message translates to:
  /// **'Ocio'**
  String get cat_ocio;

  /// No description provided for @cat_salud.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get cat_salud;

  /// No description provided for @cat_hogar.
  ///
  /// In es, this message translates to:
  /// **'Hogar'**
  String get cat_hogar;

  /// No description provided for @cat_ropa.
  ///
  /// In es, this message translates to:
  /// **'Ropa'**
  String get cat_ropa;

  /// No description provided for @cat_educacion.
  ///
  /// In es, this message translates to:
  /// **'Educación'**
  String get cat_educacion;

  /// No description provided for @cat_otros.
  ///
  /// In es, this message translates to:
  /// **'Otros'**
  String get cat_otros;

  /// No description provided for @cat_sueldo.
  ///
  /// In es, this message translates to:
  /// **'Sueldo'**
  String get cat_sueldo;

  /// No description provided for @cat_freelance.
  ///
  /// In es, this message translates to:
  /// **'Freelance'**
  String get cat_freelance;

  /// No description provided for @cat_inversiones.
  ///
  /// In es, this message translates to:
  /// **'Inversiones'**
  String get cat_inversiones;

  /// No description provided for @cat_regalos.
  ///
  /// In es, this message translates to:
  /// **'Regalos'**
  String get cat_regalos;

  /// No description provided for @cat_suscripciones.
  ///
  /// In es, this message translates to:
  /// **'Suscripciones'**
  String get cat_suscripciones;

  /// No description provided for @cat_vivienda.
  ///
  /// In es, this message translates to:
  /// **'Vivienda'**
  String get cat_vivienda;

  /// No description provided for @goodMorning.
  ///
  /// In es, this message translates to:
  /// **'Buenos días'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches'**
  String get goodEvening;

  /// No description provided for @darkMode.
  ///
  /// In es, this message translates to:
  /// **'Modo oscuro'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In es, this message translates to:
  /// **'Modo claro'**
  String get lightMode;

  /// No description provided for @currency.
  ///
  /// In es, this message translates to:
  /// **'Moneda'**
  String get currency;

  /// No description provided for @aboutApp.
  ///
  /// In es, this message translates to:
  /// **'Sobre la app'**
  String get aboutApp;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @update.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get update;

  /// No description provided for @editLimit.
  ///
  /// In es, this message translates to:
  /// **'Editar límite'**
  String get editLimit;

  /// No description provided for @newLimit.
  ///
  /// In es, this message translates to:
  /// **'Nuevo límite'**
  String get newLimit;

  /// No description provided for @deleteBudget.
  ///
  /// In es, this message translates to:
  /// **'Eliminar presupuesto'**
  String get deleteBudget;

  /// No description provided for @deleteBudgetConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este presupuesto?'**
  String get deleteBudgetConfirm;

  /// No description provided for @deleteTransaction.
  ///
  /// In es, this message translates to:
  /// **'Eliminar transacción'**
  String get deleteTransaction;

  /// No description provided for @deleteTransactionConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de eliminar esta transacción?'**
  String get deleteTransactionConfirm;

  /// No description provided for @editTransaction.
  ///
  /// In es, this message translates to:
  /// **'Editar transacción'**
  String get editTransaction;

  /// No description provided for @joinGroup.
  ///
  /// In es, this message translates to:
  /// **'Unirse a un grupo'**
  String get joinGroup;

  /// No description provided for @joinWithCode.
  ///
  /// In es, this message translates to:
  /// **'Unirse con código'**
  String get joinWithCode;

  /// No description provided for @join.
  ///
  /// In es, this message translates to:
  /// **'Unirse'**
  String get join;

  /// No description provided for @inviteCode.
  ///
  /// In es, this message translates to:
  /// **'Código de invitación'**
  String get inviteCode;

  /// No description provided for @code.
  ///
  /// In es, this message translates to:
  /// **'Código'**
  String get code;

  /// No description provided for @copy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get copy;

  /// No description provided for @share.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get share;

  /// No description provided for @codeCopied.
  ///
  /// In es, this message translates to:
  /// **'Código copiado al portapapeles'**
  String get codeCopied;

  /// No description provided for @invalidCode.
  ///
  /// In es, this message translates to:
  /// **'Código no válido. Comprueba e inténtalo de nuevo.'**
  String get invalidCode;

  /// No description provided for @alreadyMember.
  ///
  /// In es, this message translates to:
  /// **'Ya eres miembro de este grupo.'**
  String get alreadyMember;

  /// No description provided for @joinedGroup.
  ///
  /// In es, this message translates to:
  /// **'Te has unido al grupo correctamente.'**
  String get joinedGroup;

  /// No description provided for @removeMember.
  ///
  /// In es, this message translates to:
  /// **'Eliminar miembro'**
  String get removeMember;

  /// No description provided for @removeMemberConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar a {name} del grupo?'**
  String removeMemberConfirm(String name);

  /// No description provided for @shareInvite.
  ///
  /// In es, this message translates to:
  /// **'Únete a mi grupo \"{group}\" en BalanceTracker con el código: {code}'**
  String shareInvite(String group, String code);

  /// No description provided for @inviteSubject.
  ///
  /// In es, this message translates to:
  /// **'Invitación a grupo BalanceTracker'**
  String get inviteSubject;

  /// No description provided for @shareCodePrompt.
  ///
  /// In es, this message translates to:
  /// **'Comparte este código para que otros se unan a \"{group}\":'**
  String shareCodePrompt(String group);

  /// No description provided for @joinCodeHint.
  ///
  /// In es, this message translates to:
  /// **'Introduce el código de invitación que te han compartido.'**
  String get joinCodeHint;

  /// No description provided for @yourSharedGroups.
  ///
  /// In es, this message translates to:
  /// **'Tus grupos compartidos'**
  String get yourSharedGroups;

  /// No description provided for @createOrJoin.
  ///
  /// In es, this message translates to:
  /// **'Crea un grupo o únete con un código'**
  String get createOrJoin;

  /// No description provided for @selectMemberForSplit.
  ///
  /// In es, this message translates to:
  /// **'Selecciona al menos un miembro para dividir el gasto.'**
  String get selectMemberForSplit;

  /// No description provided for @divideBetween.
  ///
  /// In es, this message translates to:
  /// **'Divide entre:'**
  String get divideBetween;

  /// No description provided for @pendingPayment.
  ///
  /// In es, this message translates to:
  /// **'Pago pendiente'**
  String get pendingPayment;

  /// No description provided for @owesTo.
  ///
  /// In es, this message translates to:
  /// **'{from} debe a {to}'**
  String owesTo(String from, String to);
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
