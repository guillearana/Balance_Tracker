import 'package:balance_tracker/core/providers/locale_provider.dart';
import 'package:balance_tracker/core/router/app_router.dart';
import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_provider.dart';
import 'package:balance_tracker/features/subscriptions/data/repositories/subscription_provider.dart';
import 'package:balance_tracker/features/debts/data/repositories/debt_provider.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:balance_tracker/features/subscriptions/domain/models/subscription_model.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:balance_tracker/features/transactions/presentation/screens/add_transaction_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: Text(l10n.changeLanguage),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _showLanguageDialog(context, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFFFF7675)),
                title: Text(l10n.signOut,
                    style: const TextStyle(color: Color(0xFFFF7675))),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (d) => AlertDialog(
                      title: Text(l10n.signOut),
                      content: Text(l10n.signOutConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(d).pop(false),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(d).pop(true),
                          child: Text(l10n.signOut,
                              style: const TextStyle(
                                  color: Color(0xFFFF7675))),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await FirebaseAuth.instance.signOut();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.changeLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageOption(
              flag: '🇪🇸',
              label: 'Español',
              locale: const Locale('es'),
              ref: ref,
              onTap: () => Navigator.of(ctx).pop(),
            ),
            _LanguageOption(
              flag: '🇬🇧',
              label: 'English',
              locale: const Locale('en'),
              ref: ref,
              onTap: () => Navigator.of(ctx).pop(),
            ),
            _LanguageOption(
              flag: '🏴',
              label: 'Euskera',
              locale: const Locale('eu'),
              ref: ref,
              onTap: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final user = ref.watch(currentUserProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final subscriptionsAsync = ref.watch(subscriptionsProvider);
    ref.watch(debtsProvider);
    final theme = Theme.of(context);
    final now = DateTime.now();
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => ProviderScope(
            parent: ProviderScope.containerOf(context),
            child: const AddTransactionScreen(),
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.hello}, ${user?.displayName?.split(' ').first ?? 'Usuario'}',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          DateFormat('MMMM yyyy', locale).format(now),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _showProfileMenu(context, ref),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          (user?.displayName?.isNotEmpty == true)
                              ? user!.displayName![0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: transactionsAsync.when(
                data: (transactions) {
                  final monthTransactions = transactions
                      .where((t) =>
                          t.date.month == now.month &&
                          t.date.year == now.year)
                      .toList();
                  final income = monthTransactions
                      .where((t) => t.type == TransactionType.income)
                      .fold(0.0, (sum, t) => sum + t.amount);
                  final expense = monthTransactions
                      .where((t) => t.type == TransactionType.expense)
                      .fold(0.0, (sum, t) => sum + t.amount);
                  final balance = income - expense;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.balance,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    context.push(AppRoutes.transactions),
                                child: Row(
                                  children: [
                                    Text(
                                      l10n.showMore,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.white
                                            .withValues(alpha: 0.8),
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                      color: Colors.white
                                          .withValues(alpha: 0.8),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currencyFormat.format(balance),
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryChip(
                                  label: l10n.income,
                                  amount: currencyFormat.format(income),
                                  icon: Icons.arrow_downward_rounded,
                                  color: const Color(0xFF55EFC4),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SummaryChip(
                                  label: l10n.expense,
                                  amount: currencyFormat.format(expense),
                                  icon: Icons.arrow_upward_rounded,
                                  color: const Color(0xFFFF7675),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(20),
                  child: _BalanceCardSkeleton(),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
                child: Text(
                  l10n.latestTransactions,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            transactionsAsync.when(
              data: (transactions) {
                final recent = transactions.take(5).toList();
                if (recent.isEmpty) {
                  return SliverToBoxAdapter(
                    child: _EmptyState(
                      icon: Icons.receipt_long_outlined,
                      message: l10n.noTransactions,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: _TransactionTile(transaction: recent[index]),
                    ),
                    childCount: recent.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
                child: Text(
                  l10n.upcomingPayments,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            subscriptionsAsync.when(
              data: (subscriptions) {
                final upcoming = subscriptions
                    .where((s) => s.nextPayment.isAfter(DateTime.now()))
                    .take(3)
                    .toList();
                if (upcoming.isEmpty) {
                  return SliverToBoxAdapter(
                    child: _EmptyState(
                      icon: Icons.repeat_outlined,
                      message: l10n.noPayments,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: _SubscriptionTile(subscription: upcoming[index]),
                    ),
                    childCount: upcoming.length,
                  ),
                );
              },
              loading: () =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final Locale locale;
  final WidgetRef ref;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.locale,
    required this.ref,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final isSelected = currentLocale.languageCode == locale.languageCode;
    final theme = Theme.of(context);

    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(label),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        ref.read(localeNotifierProvider.notifier).setLocale(locale);
        onTap();
      },
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String amount;
  final IconData icon;
  final Color color;

  const _SummaryChip({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  amount,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final isIncome = transaction.type == TransactionType.income;
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isIncome
                  ? const Color(0xFF55EFC4).withValues(alpha: 0.15)
                  : const Color(0xFFFF7675).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isIncome
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: isIncome
                  ? const Color(0xFF55EFC4)
                  : const Color(0xFFFF7675),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.note ??
                      (isIncome ? l10n.income : l10n.expense),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy', locale).format(transaction.date),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}${currencyFormat.format(transaction.amount)}',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isIncome
                  ? const Color(0xFF55EFC4)
                  : const Color(0xFFFF7675),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionTile extends StatelessWidget {
  final SubscriptionModel subscription;

  const _SubscriptionTile({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final daysLeft =
        subscription.nextPayment.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.repeat_rounded,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subscription.name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  l10n.daysLeft(daysLeft),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: daysLeft <= 3
                        ? const Color(0xFFFF7675)
                        : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Text(
            currencyFormat.format(subscription.amount),
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: [
          Icon(icon,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              size: 20),
          const SizedBox(width: 8),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceCardSkeleton extends StatelessWidget {
  const _BalanceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}