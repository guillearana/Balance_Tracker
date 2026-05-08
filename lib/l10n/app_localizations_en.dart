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
  String get rememberSession => 'Remember me';

  @override
  String get navLimits => 'Limits';

  @override
  String get navPayments => 'Payments';

  @override
  String get members => 'Members';

  @override
  String get admin => 'Admin';

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

  @override
  String get createAccount => 'Create account';

  @override
  String get createAccountSubtitle => 'Start managing your finances today';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get signIn => 'Sign in';

  @override
  String get errorEmailInUse => 'An account already exists with this email.';

  @override
  String get errorWeakPassword => 'The password is too weak.';

  @override
  String get transactions => 'Transactions';

  @override
  String get all => 'All';

  @override
  String get noTransactionsFound => 'No transactions';

  @override
  String get noCategory => 'No category';

  @override
  String get errorLoadingTransactions => 'Error loading transactions';

  @override
  String get newTransaction => 'New transaction';

  @override
  String get selectCategory => 'Select a category';

  @override
  String get enterAmount => 'Enter an amount';

  @override
  String get invalidAmount => 'Invalid amount';

  @override
  String get category => 'Category';

  @override
  String get date => 'Date';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get save => 'Save';

  @override
  String get errorLoadingCategories => 'Error loading categories';

  @override
  String get financialControl => 'Financial control';

  @override
  String get budgets => 'Budgets';

  @override
  String get debts => 'Debts';

  @override
  String get add => 'Add';

  @override
  String get noBudgets => 'No budgets';

  @override
  String get addBudget => 'Add budget';

  @override
  String get newBudget => 'New budget';

  @override
  String get monthlyLimit => 'Monthly limit';

  @override
  String limitExceededBy(String amount) {
    return 'Limit exceeded by $amount';
  }

  @override
  String nearLimitRemaining(String amount) {
    return 'Near limit — $amount remaining';
  }

  @override
  String spentOf(String spent, String total) {
    return '$spent of $total';
  }

  @override
  String get completeAllFields => 'Complete all fields';

  @override
  String get noDebts => 'No debts recorded';

  @override
  String get addDebt => 'Add debt';

  @override
  String get newDebt => 'New debt';

  @override
  String get totalPending => 'Total pending';

  @override
  String get totalAmount => 'Total amount';

  @override
  String get monthlyPayment => 'Monthly payment (€)';

  @override
  String get dueDate => 'Due date';

  @override
  String due(String date) {
    return 'Due: $date';
  }

  @override
  String ofTotal(String total) {
    return 'of $total';
  }

  @override
  String installment(String amount) {
    return 'Payment: $amount/mo';
  }

  @override
  String get markPaid => 'Mark as paid';

  @override
  String get delete => 'Delete';

  @override
  String get deleteDebt => 'Delete debt';

  @override
  String deleteDebtConfirm(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get no => 'No';

  @override
  String get yesDelete => 'Yes, delete';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get noActiveSubscriptions => 'No active subscriptions';

  @override
  String get addSubscription => 'Add subscription';

  @override
  String get newSubscription => 'New subscription';

  @override
  String get totalMonthlyExpense => 'Total monthly expense';

  @override
  String get monthly => 'Monthly';

  @override
  String get annual => 'Annual';

  @override
  String get weekly => 'Weekly';

  @override
  String nextIn(int days) {
    return 'Next in $days days';
  }

  @override
  String get cancelSubscription => 'Cancel subscription';

  @override
  String cancelSubscriptionConfirm(String name) {
    return 'Cancel \"$name\"? It will stop generating charges.';
  }

  @override
  String get yesCancel => 'Yes, cancel';

  @override
  String get amount => 'Amount';

  @override
  String get frequency => 'Frequency';

  @override
  String get paymentMode => 'Payment mode';

  @override
  String get automatic => 'Automatic';

  @override
  String get manual => 'Manual';

  @override
  String get groups => 'Groups';

  @override
  String get noGroupsCreated => 'No groups created';

  @override
  String get createGroup => 'Create group';

  @override
  String get newGroup => 'New group';

  @override
  String get groupName => 'Group name';

  @override
  String get enterGroupName => 'Enter a name for the group';

  @override
  String get deleteGroup => 'Delete group';

  @override
  String deleteGroupConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get balances => 'Balances';

  @override
  String get expenses => 'Expenses';

  @override
  String get noExpensesYet => 'No expenses yet';

  @override
  String paidBy(String name) {
    return 'Paid by: $name';
  }

  @override
  String get addExpense => 'Add expense';

  @override
  String get description => 'Description';

  @override
  String get errorLoadingGroups => 'Error loading groups';

  @override
  String get userNotAuthenticated => 'User not authenticated';

  @override
  String get errorLoadingData => 'Error loading data';

  @override
  String get analysis => 'Analytics';

  @override
  String get incomeVsExpense => 'Income vs Expenses';

  @override
  String get last6Months => 'Last 6 months';

  @override
  String get expensesByCategory => 'Expenses by category';

  @override
  String get noExpensesThisMonth => 'No expenses this month';

  @override
  String get incomes => 'Income';

  @override
  String memberCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '$count member',
    );
    return '$_temp0';
  }

  @override
  String get cat_comida => 'Food';

  @override
  String get cat_transporte => 'Transport';

  @override
  String get cat_ocio => 'Leisure';

  @override
  String get cat_salud => 'Health';

  @override
  String get cat_hogar => 'Home';

  @override
  String get cat_ropa => 'Clothing';

  @override
  String get cat_educacion => 'Education';

  @override
  String get cat_otros => 'Other';

  @override
  String get cat_sueldo => 'Salary';

  @override
  String get cat_freelance => 'Freelance';

  @override
  String get cat_inversiones => 'Investments';

  @override
  String get cat_regalos => 'Gifts';

  @override
  String get cat_suscripciones => 'Subscriptions';

  @override
  String get cat_vivienda => 'Housing';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get currency => 'Currency';

  @override
  String get aboutApp => 'About the app';

  @override
  String get close => 'Close';

  @override
  String get update => 'Update';

  @override
  String get editLimit => 'Edit limit';

  @override
  String get newLimit => 'New limit';

  @override
  String get deleteBudget => 'Delete budget';

  @override
  String get deleteBudgetConfirm => 'Delete this budget?';

  @override
  String get deleteTransaction => 'Delete transaction';

  @override
  String get deleteTransactionConfirm =>
      'Are you sure you want to delete this transaction?';

  @override
  String get editTransaction => 'Edit transaction';

  @override
  String get joinGroup => 'Join a group';

  @override
  String get joinWithCode => 'Join with code';

  @override
  String get join => 'Join';

  @override
  String get inviteCode => 'Invite code';

  @override
  String get code => 'Code';

  @override
  String get copy => 'Copy';

  @override
  String get share => 'Share';

  @override
  String get codeCopied => 'Code copied to clipboard';

  @override
  String get invalidCode => 'Invalid code. Please check and try again.';

  @override
  String get alreadyMember => 'You are already a member of this group.';

  @override
  String get joinedGroup => 'You have joined the group successfully.';

  @override
  String get removeMember => 'Remove member';

  @override
  String removeMemberConfirm(String name) {
    return 'Remove $name from the group?';
  }

  @override
  String shareInvite(String group, String code) {
    return 'Join my group \"$group\" on BalanceTracker with the code: $code';
  }

  @override
  String get inviteSubject => 'BalanceTracker group invitation';

  @override
  String shareCodePrompt(String group) {
    return 'Share this code so others can join \"$group\":';
  }

  @override
  String get joinCodeHint => 'Enter the invite code that was shared with you.';

  @override
  String get yourSharedGroups => 'Your shared groups';

  @override
  String get createOrJoin => 'Create a group or join with a code';

  @override
  String get selectMemberForSplit =>
      'Select at least one member to split the expense.';

  @override
  String get divideBetween => 'Divide between:';

  @override
  String get pendingPayment => 'Pending payment';

  @override
  String owesTo(String from, String to) {
    return '$from owes $to';
  }
}
