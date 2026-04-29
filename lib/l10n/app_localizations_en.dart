// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BalanceTracker';

  @override
  String get hello => 'Hello';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get balance => 'Monthly balance';

  @override
  String get showMore => 'Show more';

  @override
  String get latestTransactions => 'Latest transactions';

  @override
  String get upcomingPayments => 'Upcoming payments';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get noPayments => 'No upcoming payments';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String daysLeft(int days) {
    return 'In $days days';
  }

  @override
  String get appSubtitle => 'Control your personal finances';

  @override
  String get login => 'Sign in';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get minChars => 'Minimum 6 characters';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Sign up';

  @override
  String get errorDefault => 'An error occurred. Please try again.';

  @override
  String get errorUserNotFound => 'No account found with this email.';

  @override
  String get errorWrongPassword => 'Incorrect password.';

  @override
  String get errorUserDisabled => 'This account has been disabled.';

  @override
  String get errorInvalidCredential => 'Incorrect email or password.';
}
