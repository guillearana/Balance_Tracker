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
  String get rememberSession => 'Saioa gogoratu';

  @override
  String get navLimits => 'Mugak';

  @override
  String get navPayments => 'Ordainketak';

  @override
  String get members => 'Kideak';

  @override
  String get admin => 'Administratzailea';

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

  @override
  String get createAccount => 'Kontua sortu';

  @override
  String get createAccountSubtitle => 'Hasi zure finantzak kontrolatzen gaur';

  @override
  String get name => 'Izena';

  @override
  String get enterName => 'Sartu zure izena';

  @override
  String get confirmPassword => 'Pasahitza berretsi';

  @override
  String get confirmYourPassword => 'Berretsi zure pasahitza';

  @override
  String get passwordsDoNotMatch => 'Pasahitzak ez datoz bat';

  @override
  String get alreadyHaveAccount => 'Kontua baduzu? ';

  @override
  String get signIn => 'Saioa hasi';

  @override
  String get errorEmailInUse => 'Dagoeneko kontu bat dago email honekin.';

  @override
  String get errorWeakPassword => 'Pasahitza ahulegia da.';

  @override
  String get transactions => 'Transakzioak';

  @override
  String get all => 'Denak';

  @override
  String get noTransactionsFound => 'Ez dago transakziorik';

  @override
  String get noCategory => 'Kategoriarik gabe';

  @override
  String get errorLoadingTransactions => 'Errorea transakzioak kargatzean';

  @override
  String get newTransaction => 'Transakzio berria';

  @override
  String get selectCategory => 'Hautatu kategoria bat';

  @override
  String get enterAmount => 'Sartu kopuru bat';

  @override
  String get invalidAmount => 'Kopuru baliogabea';

  @override
  String get category => 'Kategoria';

  @override
  String get date => 'Data';

  @override
  String get noteOptional => 'Oharra (aukerakoa)';

  @override
  String get save => 'Gorde';

  @override
  String get errorLoadingCategories => 'Errorea kategoriak kargatzean';

  @override
  String get financialControl => 'Finantza kontrola';

  @override
  String get budgets => 'Aurrekontuak';

  @override
  String get debts => 'Zorrak';

  @override
  String get add => 'Gehitu';

  @override
  String get noBudgets => 'Ez dago aurrekonturik';

  @override
  String get addBudget => 'Aurrekontua gehitu';

  @override
  String get newBudget => 'Aurrekontu berria';

  @override
  String get monthlyLimit => 'Hileko muga';

  @override
  String limitExceededBy(String amount) {
    return 'Muga gaindituta $amount-(e)n';
  }

  @override
  String nearLimitRemaining(String amount) {
    return 'Mugaren ondoan — $amount geratzen da';
  }

  @override
  String spentOf(String spent, String total) {
    return '$spent / $total';
  }

  @override
  String get completeAllFields => 'Bete eremu guztiak';

  @override
  String get noDebts => 'Ez dago zorrik erregistratuta';

  @override
  String get addDebt => 'Zorra gehitu';

  @override
  String get newDebt => 'Zor berria';

  @override
  String get totalPending => 'Guztira zain';

  @override
  String get totalAmount => 'Kopuru osoa';

  @override
  String get monthlyPayment => 'Hileko kuota';

  @override
  String get dueDate => 'Epemuga';

  @override
  String due(String date) {
    return 'Epemuga: $date';
  }

  @override
  String ofTotal(String total) {
    return '/ $total';
  }

  @override
  String installment(String amount) {
    return 'Kuota: $amount/hil';
  }

  @override
  String get markPaid => 'Ordainduta markatu';

  @override
  String get delete => 'Ezabatu';

  @override
  String get deleteDebt => 'Zorra ezabatu';

  @override
  String deleteDebtConfirm(String name) {
    return '\"$name\" ezabatu?';
  }

  @override
  String get no => 'Ez';

  @override
  String get yesDelete => 'Bai, ezabatu';

  @override
  String get subscriptions => 'Harpidetzak';

  @override
  String get noActiveSubscriptions => 'Ez dago harpidetza aktiborik';

  @override
  String get addSubscription => 'Harpidetza gehitu';

  @override
  String get newSubscription => 'Harpidetza berria';

  @override
  String get totalMonthlyExpense => 'Hileko gastu osoa';

  @override
  String get monthly => 'Hilekoa';

  @override
  String get annual => 'Urtekoa';

  @override
  String get weekly => 'Astekoa';

  @override
  String nextIn(int days) {
    return 'Hurrengo $days egunetan';
  }

  @override
  String get cancelSubscription => 'Harpidetza bertan behera utzi';

  @override
  String cancelSubscriptionConfirm(String name) {
    return '\"$name\" bertan behera utzi? Kobruak sortzeari utziko dio.';
  }

  @override
  String get yesCancel => 'Bai, utzi';

  @override
  String get amount => 'Kopurua';

  @override
  String get frequency => 'Maiztasuna';

  @override
  String get paymentMode => 'Ordainketa modua';

  @override
  String get automatic => 'Automatikoa';

  @override
  String get manual => 'Eskuzkoa';

  @override
  String get groups => 'Taldeak';

  @override
  String get noGroupsCreated => 'Ez dago talderik sortuta';

  @override
  String get createGroup => 'Taldea sortu';

  @override
  String get newGroup => 'Talde berria';

  @override
  String get groupName => 'Taldearen izena';

  @override
  String get enterGroupName => 'Sartu taldearen izena';

  @override
  String get deleteGroup => 'Taldea ezabatu';

  @override
  String deleteGroupConfirm(String name) {
    return 'Ziur zaude \"$name\" ezabatu nahi duzula?';
  }

  @override
  String get balances => 'Saldoak';

  @override
  String get expenses => 'Gastuak';

  @override
  String get noExpensesYet => 'Oraindik gasturik ez';

  @override
  String paidBy(String name) {
    return 'Ordaindu du: $name';
  }

  @override
  String get addExpense => 'Gastua gehitu';

  @override
  String get description => 'Deskribapena';

  @override
  String get errorLoadingGroups => 'Errorea taldeak kargatzean';

  @override
  String get userNotAuthenticated => 'Erabiltzailea autentifikatu gabe';

  @override
  String get errorLoadingData => 'Errorea datuak kargatzean';

  @override
  String get analysis => 'Analisia';

  @override
  String get incomeVsExpense => 'Sarrerak vs Gastuak';

  @override
  String get last6Months => 'Azken 6 hilabeteak';

  @override
  String get expensesByCategory => 'Gastuak kategoriaka';

  @override
  String get noExpensesThisMonth => 'Hilabete honetan gasturik ez';

  @override
  String get incomes => 'Sarrerak';

  @override
  String memberCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kide',
      one: '$count kide',
    );
    return '$_temp0';
  }

  @override
  String get cat_comida => 'Janaria';

  @override
  String get cat_transporte => 'Garraioa';

  @override
  String get cat_ocio => 'Aisia';

  @override
  String get cat_salud => 'Osasuna';

  @override
  String get cat_hogar => 'Etxea';

  @override
  String get cat_ropa => 'Arropa';

  @override
  String get cat_educacion => 'Hezkuntza';

  @override
  String get cat_otros => 'Beste batzuk';

  @override
  String get cat_sueldo => 'Soldata';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_inversiones => 'Inbertsioak';

  @override
  String get cat_regalos => 'Opariak';

  @override
  String get cat_suscripciones => 'Harpidetzak';

  @override
  String get cat_vivienda => 'Etxebizitza';

  @override
  String get goodMorning => 'Egun on';

  @override
  String get goodAfternoon => 'Arratsalde on';

  @override
  String get goodEvening => 'Gabon';

  @override
  String get darkMode => 'Modu iluna';

  @override
  String get lightMode => 'Modu argia';

  @override
  String get currency => 'Moneta';

  @override
  String get aboutApp => 'Aplikazioari buruz';

  @override
  String get close => 'Itxi';

  @override
  String get update => 'Eguneratu';

  @override
  String get editLimit => 'Muga editatu';

  @override
  String get newLimit => 'Muga berria';

  @override
  String get deleteBudget => 'Aurrekontua ezabatu';

  @override
  String get deleteBudgetConfirm => 'Aurrekontu hau ezabatu?';

  @override
  String get deleteTransaction => 'Transakzioa ezabatu';

  @override
  String get deleteTransactionConfirm =>
      'Ziur zaude transakzio hau ezabatu nahi duzula?';

  @override
  String get editTransaction => 'Transakzioa editatu';

  @override
  String get joinGroup => 'Talde batera sartu';

  @override
  String get joinWithCode => 'Kodearekin sartu';

  @override
  String get join => 'Sartu';

  @override
  String get inviteCode => 'Gonbidapen kodea';

  @override
  String get code => 'Kodea';

  @override
  String get copy => 'Kopiatu';

  @override
  String get share => 'Partekatu';

  @override
  String get codeCopied => 'Kodea arbelera kopiatua';

  @override
  String get invalidCode => 'Kode baliogabea. Egiaztatu eta saiatu berriro.';

  @override
  String get alreadyMember => 'Dagoeneko talde honetako kidea zara.';

  @override
  String get joinedGroup => 'Taldean ondo sartu zara.';

  @override
  String get removeMember => 'Kidea kendu';

  @override
  String removeMemberConfirm(String name) {
    return '$name taldetik kendu?';
  }

  @override
  String shareInvite(String group, String code) {
    return 'Sartu nire \"$group\" taldean BalanceTracker-en kode honekin: $code';
  }

  @override
  String get inviteSubject => 'BalanceTracker talde gonbidapena';

  @override
  String shareCodePrompt(String group) {
    return 'Partekatu kode hau besteak \"$group\" taldera sartu daitezen:';
  }

  @override
  String get joinCodeHint => 'Sartu partekatu dizuten gonbidapen kodea.';

  @override
  String get yourSharedGroups => 'Zure talde partekatuak';

  @override
  String get createOrJoin => 'Sortu talde bat edo sartu kode batekin';

  @override
  String get selectMemberForSplit =>
      'Hautatu gutxienez kide bat gastua banatzeko.';

  @override
  String get divideBetween => 'Banatu:';

  @override
  String get pendingPayment => 'Ordainketa pendientea';

  @override
  String owesTo(String from, String to) {
    return '$from-(e)k $to-(r)i zor dio';
  }
}
