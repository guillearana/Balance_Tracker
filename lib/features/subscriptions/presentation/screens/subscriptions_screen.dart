import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/subscriptions/data/repositories/subscription_provider.dart';
import 'package:balance_tracker/features/subscriptions/data/repositories/subscription_repository.dart';
import 'package:balance_tracker/features/subscriptions/domain/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';
import 'package:balance_tracker/core/providers/currency_provider.dart';

class SubscriptionsScreen extends ConsumerWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final subscriptionsAsync = ref.watch(subscriptionsProvider);
    final currencyFormat = NumberFormat.currency(
      locale: 'es_ES',
      symbol: ref.watch(currencyNotifierProvider),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.subscriptions,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showAddSheet(context, ref),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: subscriptionsAsync.when(
                data: (subscriptions) {
                  if (subscriptions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.repeat_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noActiveSubscriptions,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => _showAddSheet(context, ref),
                            child: Text(l10n.addSubscription),
                          ),
                        ],
                      ),
                    );
                  }

                  final totalMonthly = subscriptions
                      .where(
                        (s) => s.frequency == SubscriptionFrequency.monthly,
                      )
                      .fold(0.0, (sum, s) => sum + s.amount);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.totalMonthlyExpense,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                currencyFormat.format(totalMonthly),
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: subscriptions.length,
                          itemBuilder: (context, index) {
                            final sub = subscriptions[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _SubscriptionCard(
                                subscription: sub,
                                onCancel: () =>
                                    _cancelSubscription(context, ref, sub),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text('Error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cancelSubscription(
    BuildContext context,
    WidgetRef ref,
    SubscriptionModel sub,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.cancelSubscription),
        content: Text(l10n.cancelSubscriptionConfirm(sub.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.yesCancel),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      await ref
          .read(subscriptionRepositoryProvider)
          .cancelSubscription(user.uid, sub.id);
    }
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: const _AddSubscriptionSheet(),
      ),
    );
  }
}

class _SubscriptionCard extends ConsumerWidget {
  final SubscriptionModel subscription;
  final VoidCallback onCancel;

  const _SubscriptionCard({required this.subscription, required this.onCancel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currencyFormat = NumberFormat.currency(
      locale: 'es_ES',
      symbol: ref.watch(currencyNotifierProvider),
    );
    final daysLeft = subscription.nextPayment.difference(DateTime.now()).inDays;
    final isUrgent = daysLeft <= 3;

    String frequencyLabel;
    switch (subscription.frequency) {
      case SubscriptionFrequency.monthly:
        frequencyLabel = l10n.monthly;
        break;
      case SubscriptionFrequency.annual:
        frequencyLabel = l10n.annual;
        break;
      case SubscriptionFrequency.weekly:
        frequencyLabel = l10n.weekly;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent
            ? Border.all(color: const Color(0xFFFF7675).withValues(alpha: 0.5))
            : null,
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      frequencyLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '· ${l10n.nextIn(daysLeft)}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isUrgent
                            ? const Color(0xFFEF4444)
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormat.format(subscription.amount),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 20,
                ),
                onPressed: onCancel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddSubscriptionSheet extends ConsumerStatefulWidget {
  const _AddSubscriptionSheet();

  @override
  ConsumerState<_AddSubscriptionSheet> createState() =>
      _AddSubscriptionSheetState();
}

class _AddSubscriptionSheetState extends ConsumerState<_AddSubscriptionSheet> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  SubscriptionFrequency _frequency = SubscriptionFrequency.monthly;
  PaymentMode _paymentMode = PaymentMode.auto;
  DateTime _startDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime _calculateNextPayment(DateTime start, SubscriptionFrequency freq) {
    switch (freq) {
      case SubscriptionFrequency.monthly:
        return DateTime(start.year, start.month + 1, start.day);
      case SubscriptionFrequency.annual:
        return DateTime(start.year + 1, start.month, start.day);
      case SubscriptionFrequency.weekly:
        return start.add(const Duration(days: 7));
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.completeAllFields)));
      return;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return;

    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      final subscription = SubscriptionModel(
        id: const Uuid().v4(),
        userId: user.uid,
        name: _nameController.text.trim(),
        amount: amount,
        frequency: _frequency,
        startDate: _startDate,
        nextPayment: _calculateNextPayment(_startDate, _frequency),
        paymentMode: _paymentMode,
      );
      await ref
          .read(subscriptionRepositoryProvider)
          .addSubscription(user.uid, subscription);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.newSubscription,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: l10n.name,
              prefixIcon: const Icon(Icons.label_outline),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.amount,
              prefixIcon: const Icon(Icons.payments_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.frequency,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: SubscriptionFrequency.values.map((f) {
              final label = f == SubscriptionFrequency.monthly
                  ? l10n.monthly
                  : f == SubscriptionFrequency.annual
                  ? l10n.annual
                  : l10n.weekly;
              final isSelected = _frequency == f;
              return GestureDetector(
                onTap: () => setState(() => _frequency = f),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.paymentMode,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              GestureDetector(
                onTap: () => setState(() => _paymentMode = PaymentMode.auto),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _paymentMode == PaymentMode.auto
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.automatic,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _paymentMode == PaymentMode.auto
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _paymentMode = PaymentMode.manual),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _paymentMode == PaymentMode.manual
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.manual,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _paymentMode == PaymentMode.manual
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _save,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.save),
            ),
          ),
        ],
      ),
    );
  }
}
