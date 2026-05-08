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

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get createAccountSubtitle => 'Empieza a controlar tus finanzas hoy';

  @override
  String get name => 'Nombre';

  @override
  String get enterName => 'Introduce tu nombre';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get confirmYourPassword => 'Confirma tu contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? ';

  @override
  String get signIn => 'Inicia sesión';

  @override
  String get errorEmailInUse => 'Ya existe una cuenta con este email.';

  @override
  String get errorWeakPassword => 'La contraseña es demasiado débil.';

  @override
  String get transactions => 'Transacciones';

  @override
  String get all => 'Todos';

  @override
  String get noTransactionsFound => 'No hay transacciones';

  @override
  String get noCategory => 'Sin categoría';

  @override
  String get errorLoadingTransactions => 'Error cargando transacciones';

  @override
  String get newTransaction => 'Nueva transacción';

  @override
  String get selectCategory => 'Selecciona una categoría';

  @override
  String get enterAmount => 'Introduce una cantidad';

  @override
  String get invalidAmount => 'Cantidad no válida';

  @override
  String get category => 'Categoría';

  @override
  String get date => 'Fecha';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get save => 'Guardar';

  @override
  String get errorLoadingCategories => 'Error cargando categorías';

  @override
  String get financialControl => 'Control financiero';

  @override
  String get budgets => 'Presupuestos';

  @override
  String get debts => 'Deudas';

  @override
  String get add => 'Añadir';

  @override
  String get noBudgets => 'No hay presupuestos';

  @override
  String get addBudget => 'Añadir presupuesto';

  @override
  String get newBudget => 'Nuevo presupuesto';

  @override
  String get monthlyLimit => 'Límite mensual';

  @override
  String limitExceededBy(String amount) {
    return 'Límite superado por $amount';
  }

  @override
  String nearLimitRemaining(String amount) {
    return 'Cerca del límite — queda $amount';
  }

  @override
  String spentOf(String spent, String total) {
    return '$spent de $total';
  }

  @override
  String get completeAllFields => 'Completa todos los campos';

  @override
  String get noDebts => 'No hay deudas registradas';

  @override
  String get addDebt => 'Añadir deuda';

  @override
  String get newDebt => 'Nueva deuda';

  @override
  String get totalPending => 'Total pendiente';

  @override
  String get totalAmount => 'Importe total';

  @override
  String get monthlyPayment => 'Cuota mensual (€)';

  @override
  String get dueDate => 'Fecha de vencimiento';

  @override
  String due(String date) {
    return 'Vence: $date';
  }

  @override
  String ofTotal(String total) {
    return 'de $total';
  }

  @override
  String installment(String amount) {
    return 'Cuota: $amount/mes';
  }

  @override
  String get markPaid => 'Marcar pagada';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteDebt => 'Eliminar deuda';

  @override
  String deleteDebtConfirm(String name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Sí, eliminar';

  @override
  String get subscriptions => 'Suscripciones';

  @override
  String get noActiveSubscriptions => 'No hay suscripciones activas';

  @override
  String get addSubscription => 'Añadir suscripción';

  @override
  String get newSubscription => 'Nueva suscripción';

  @override
  String get totalMonthlyExpense => 'Gasto mensual total';

  @override
  String get monthly => 'Mensual';

  @override
  String get annual => 'Anual';

  @override
  String get weekly => 'Semanal';

  @override
  String nextIn(int days) {
    return 'Próximo en $days días';
  }

  @override
  String get cancelSubscription => 'Cancelar suscripción';

  @override
  String cancelSubscriptionConfirm(String name) {
    return '¿Cancelar \"$name\"? Dejará de generar cobros.';
  }

  @override
  String get yesCancel => 'Sí, cancelar';

  @override
  String get amount => 'Importe';

  @override
  String get frequency => 'Frecuencia';

  @override
  String get paymentMode => 'Modo de pago';

  @override
  String get automatic => 'Automático';

  @override
  String get manual => 'Manual';

  @override
  String get groups => 'Grupos';

  @override
  String get noGroupsCreated => 'No hay grupos creados';

  @override
  String get createGroup => 'Crear grupo';

  @override
  String get newGroup => 'Nuevo grupo';

  @override
  String get groupName => 'Nombre del grupo';

  @override
  String get enterGroupName => 'Introduce un nombre para el grupo';

  @override
  String get deleteGroup => 'Borrar grupo';

  @override
  String deleteGroupConfirm(String name) {
    return '¿Seguro que quieres borrar \"$name\"?';
  }

  @override
  String get balances => 'Balances';

  @override
  String get expenses => 'Gastos';

  @override
  String get noExpensesYet => 'No hay gastos aún';

  @override
  String paidBy(String name) {
    return 'Pagado por: $name';
  }

  @override
  String get addExpense => 'Añadir gasto';

  @override
  String get description => 'Descripción';

  @override
  String get errorLoadingGroups => 'Error cargando grupos';

  @override
  String get userNotAuthenticated => 'Usuario no autenticado';

  @override
  String get errorLoadingData => 'Error cargando datos';

  @override
  String get analysis => 'Análisis';

  @override
  String get incomeVsExpense => 'Ingresos vs Gastos';

  @override
  String get last6Months => 'Últimos 6 meses';

  @override
  String get expensesByCategory => 'Gastos por categoría';

  @override
  String get noExpensesThisMonth => 'No hay gastos este mes';

  @override
  String get incomes => 'Ingresos';

  @override
  String get cat_comida => 'Comida';

  @override
  String get cat_transporte => 'Transporte';

  @override
  String get cat_ocio => 'Ocio';

  @override
  String get cat_salud => 'Salud';

  @override
  String get cat_hogar => 'Hogar';

  @override
  String get cat_ropa => 'Ropa';

  @override
  String get cat_educacion => 'Educación';

  @override
  String get cat_otros => 'Otros';

  @override
  String get cat_sueldo => 'Sueldo';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_inversiones => 'Inversiones';

  @override
  String get cat_regalos => 'Regalos';

  @override
  String get cat_suscripciones => 'Suscripciones';

  @override
  String get cat_vivienda => 'Vivienda';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodAfternoon => 'Buenas tardes';

  @override
  String get goodEvening => 'Buenas noches';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get currency => 'Moneda';

  @override
  String get aboutApp => 'Sobre la app';

  @override
  String get close => 'Cerrar';

  @override
  String get update => 'Actualizar';

  @override
  String get editLimit => 'Editar límite';

  @override
  String get newLimit => 'Nuevo límite';

  @override
  String get deleteBudget => 'Eliminar presupuesto';

  @override
  String get deleteBudgetConfirm => '¿Eliminar este presupuesto?';

  @override
  String get deleteTransaction => 'Eliminar transacción';

  @override
  String get deleteTransactionConfirm =>
      '¿Estás seguro de eliminar esta transacción?';

  @override
  String get editTransaction => 'Editar transacción';

  @override
  String get joinGroup => 'Unirse a un grupo';

  @override
  String get joinWithCode => 'Unirse con código';

  @override
  String get join => 'Unirse';

  @override
  String get inviteCode => 'Código de invitación';

  @override
  String get code => 'Código';

  @override
  String get copy => 'Copiar';

  @override
  String get share => 'Compartir';

  @override
  String get codeCopied => 'Código copiado al portapapeles';

  @override
  String get invalidCode => 'Código no válido. Comprueba e inténtalo de nuevo.';

  @override
  String get alreadyMember => 'Ya eres miembro de este grupo.';

  @override
  String get joinedGroup => 'Te has unido al grupo correctamente.';

  @override
  String get removeMember => 'Eliminar miembro';

  @override
  String removeMemberConfirm(String name) {
    return '¿Eliminar a $name del grupo?';
  }

  @override
  String shareInvite(String group, String code) {
    return 'Únete a mi grupo \"$group\" en BalanceTracker con el código: $code';
  }

  @override
  String get inviteSubject => 'Invitación a grupo BalanceTracker';

  @override
  String shareCodePrompt(String group) {
    return 'Comparte este código para que otros se unan a \"$group\":';
  }

  @override
  String get joinCodeHint =>
      'Introduce el código de invitación que te han compartido.';

  @override
  String get yourSharedGroups => 'Tus grupos compartidos';

  @override
  String get createOrJoin => 'Crea un grupo o únete con un código';

  @override
  String get selectMemberForSplit =>
      'Selecciona al menos un miembro para dividir el gasto.';

  @override
  String get divideBetween => 'Divide entre:';

  @override
  String get pendingPayment => 'Pago pendiente';

  @override
  String owesTo(String from, String to) {
    return '$from debe a $to';
  }
}
