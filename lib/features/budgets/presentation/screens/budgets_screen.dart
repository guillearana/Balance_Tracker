import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/budgets/data/repositories/budget_provider.dart';
import 'package:balance_tracker/features/budgets/data/repositories/budget_repository.dart';
import 'package:balance_tracker/features/budgets/domain/models/budget_model.dart';
import 'package:balance_tracker/features/categories/data/repositories/category_provider.dart';
import 'package:balance_tracker/features/categories/domain/models/category_model.dart';
import 'package:balance_tracker/features/debts/data/repositories/debt_provider.dart';
import 'package:balance_tracker/features/debts/data/repositories/debt_repository.dart';
import 'package:balance_tracker/features/debts/domain/models/debt_model.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_provider.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Text(
                  'Control financiero',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  tabs: const [
                    Tab(text: 'Presupuestos'),
                    Tab(text: 'Deudas'),
                  ],
                  labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.inter(),
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    _BudgetsTab(),
                    _DebtsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetsTab extends ConsumerWidget {
  const _BudgetsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final budgetsAsync = ref.watch(budgetsProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final now = DateTime.now();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy', 'es_ES').format(now),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              TextButton.icon(
                onPressed: () => _showAddBudgetSheet(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Añadir'),
              ),
            ],
          ),
        ),
        Expanded(
          child: budgetsAsync.when(
            data: (budgets) {
              if (budgets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart_outline,
                          size: 64,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
                      const SizedBox(height: 16),
                      Text(
                        'No hay presupuestos',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _showAddBudgetSheet(context, ref),
                        child: const Text('Añadir presupuesto'),
                      ),
                    ],
                  ),
                );
              }
              return transactionsAsync.when(
                data: (transactions) {
                  final monthTransactions = transactions
                      .where((t) =>
                          t.date.month == now.month &&
                          t.date.year == now.year &&
                          t.type == TransactionType.expense)
                      .toList();
                  return categoriesAsync.when(
                    data: (categories) => ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final budget = budgets[index];
                        final spent = monthTransactions
                            .where((t) => t.categoryId == budget.categoryId)
                            .fold(0.0, (sum, t) => sum + t.amount);
                        final category = categories.firstWhere(
                          (c) => c.id == budget.categoryId,
                          orElse: () => CategoryModel(
                            id: '',
                            name: 'Sin categoría',
                            icon: 'category',
                            color: '#B2BEB5',
                          ),
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 8),
                          child: _BudgetCard(
                            budget: budget,
                            category: category,
                            spent: spent,
                            onDelete: () => _deleteBudget(context, ref, budget),
                          ),
                        );
                      },
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox.shrink(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text('Error')),
          ),
        ),
      ],
    );
  }

  void _deleteBudget(BuildContext context, WidgetRef ref, BudgetModel budget) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    await ref.read(budgetRepositoryProvider).deleteBudget(user.uid, budget.id);
  }

  void _showAddBudgetSheet(BuildContext context, WidgetRef ref) {
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
        child: const _AddBudgetSheet(),
      ),
    );
  }
}

class _DebtsTab extends ConsumerWidget {
  const _DebtsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final debtsAsync = ref.watch(debtsProvider);
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showAddSheet(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Añadir'),
              ),
            ],
          ),
        ),
        Expanded(
          child: debtsAsync.when(
            data: (debts) {
              if (debts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
                      const SizedBox(height: 16),
                      Text(
                        'No hay deudas registradas',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _showAddSheet(context, ref),
                        child: const Text('Añadir deuda'),
                      ),
                    ],
                  ),
                );
              }
              final totalPending = debts
                  .where((d) => d.status == DebtStatus.active)
                  .fold(0.0, (sum, d) => sum + d.pendingAmount);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7675).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total pendiente',
                              style: GoogleFonts.inter(fontSize: 14)),
                          Text(
                            currencyFormat.format(totalPending),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF7675),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: debts.length,
                      itemBuilder: (context, index) {
                        final debt = debts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _DebtCard(
                            debt: debt,
                            onMarkPaid: () => _markAsPaid(ref, debt),
                            onDelete: () => _deleteDebt(context, ref, debt),
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
    );
  }

  void _markAsPaid(WidgetRef ref, DebtModel debt) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final updated = debt.copyWith(status: DebtStatus.paid, pendingAmount: 0);
    await ref.read(debtRepositoryProvider).updateDebt(user.uid, updated);
  }

  void _deleteDebt(BuildContext context, WidgetRef ref, DebtModel debt) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar deuda'),
        content: Text('¿Eliminar "${debt.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sí, eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      await ref.read(debtRepositoryProvider).deleteDebt(user.uid, debt.id);
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
        child: const _AddDebtSheet(),
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final BudgetModel budget;
  final CategoryModel category;
  final double spent;
  final VoidCallback onDelete;

  const _BudgetCard({
    required this.budget,
    required this.category,
    required this.spent,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final progress = (spent / budget.limitAmount).clamp(0.0, 1.0);
    final isOverBudget = spent >= budget.limitAmount;
    final isNearLimit = progress >= budget.alertThreshold && !isOverBudget;
    final categoryColor = _hexToColor(category.color);

    Color progressColor;
    if (isOverBudget) {
      progressColor = const Color(0xFFFF7675);
    } else if (isNearLimit) {
      progressColor = const Color(0xFFFDCB6E);
    } else {
      progressColor = const Color(0xFF55EFC4);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.category_outlined, color: categoryColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.name,
                        style: GoogleFonts.inter(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    Text(
                      '${currencyFormat.format(spent)} de ${currencyFormat.format(budget.limitAmount)}',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3), size: 20),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
            ),
          ),
          if (isOverBudget) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF7675), size: 14),
                const SizedBox(width: 4),
                Text(
                  'Límite superado por ${currencyFormat.format(spent - budget.limitAmount)}',
                  style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFFF7675)),
                ),
              ],
            ),
          ] else if (isNearLimit) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFFFDCB6E), size: 14),
                const SizedBox(width: 4),
                Text(
                  'Cerca del límite — queda ${currencyFormat.format(budget.limitAmount - spent)}',
                  style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFFDCB6E)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.grey;
    }
  }
}

class _DebtCard extends StatelessWidget {
  final DebtModel debt;
  final VoidCallback onMarkPaid;
  final VoidCallback onDelete;

  const _DebtCard({
    required this.debt,
    required this.onMarkPaid,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final isPaid = debt.status == DebtStatus.paid;
    final isOverdue = debt.dueDate.isBefore(DateTime.now()) && !isPaid;
    final progress = ((debt.totalAmount - debt.pendingAmount) / debt.totalAmount).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: isOverdue
            ? Border.all(color: const Color(0xFFFF7675).withValues(alpha: 0.5))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isPaid
                      ? const Color(0xFF55EFC4).withValues(alpha: 0.15)
                      : const Color(0xFFFF7675).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isPaid ? Icons.check_circle_outline : Icons.account_balance_outlined,
                  color: isPaid ? const Color(0xFF55EFC4) : const Color(0xFFFF7675),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      debt.name,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        decoration: isPaid ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      'Vence: ${DateFormat('dd/MM/yyyy').format(debt.dueDate)}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isOverdue
                            ? const Color(0xFFFF7675)
                            : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencyFormat.format(debt.pendingAmount),
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? const Color(0xFF55EFC4) : const Color(0xFFFF7675),
                    ),
                  ),
                  Text(
                    'de ${currencyFormat.format(debt.totalAmount)}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                isPaid ? const Color(0xFF55EFC4) : const Color(0xFF6C63FF),
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cuota: ${currencyFormat.format(debt.monthlyPayment)}/mes',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              Row(
                children: [
                  if (!isPaid)
                    GestureDetector(
                      onTap: onMarkPaid,
                      child: Text(
                        'Marcar pagada',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF55EFC4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onDelete,
                    child: Text(
                      'Eliminar',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFFFF7675),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddBudgetSheet extends ConsumerStatefulWidget {
  const _AddBudgetSheet();

  @override
  ConsumerState<_AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends ConsumerState<_AddBudgetSheet> {
  final _amountController = TextEditingController();
  String? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selectedCategoryId == null || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return;
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      final now = DateTime.now();
      final budget = BudgetModel(
        id: const Uuid().v4(),
        userId: user.uid,
        categoryId: _selectedCategoryId!,
        limitAmount: amount,
        periodMonth: '${now.year}-${now.month.toString().padLeft(2, '0')}',
        alertThreshold: 0.8,
      );
      await ref.read(budgetRepositoryProvider).addBudget(user.uid, budget);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nuevo presupuesto',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Límite mensual (€)',
              prefixIcon: Icon(Icons.euro_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Text('Categoría',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          categoriesAsync.when(
            data: (categories) {
              final expenses = categories.where((c) => c.type == 'expense').toList();
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: expenses.map((cat) {
                  final isSelected = _selectedCategoryId == cat.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryId = cat.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cat.name,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
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
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddDebtSheet extends ConsumerStatefulWidget {
  const _AddDebtSheet();

  @override
  ConsumerState<_AddDebtSheet> createState() => _AddDebtSheetState();
}

class _AddDebtSheetState extends ConsumerState<_AddDebtSheet> {
  final _nameController = TextEditingController();
  final _totalController = TextEditingController();
  final _monthlyController = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 365));
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _totalController.dispose();
    _monthlyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (_nameController.text.isEmpty ||
        _totalController.text.isEmpty ||
        _monthlyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }
    final total = double.tryParse(_totalController.text.replaceAll(',', '.'));
    final monthly = double.tryParse(_monthlyController.text.replaceAll(',', '.'));
    if (total == null || monthly == null) return;
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      final debt = DebtModel(
        id: const Uuid().v4(),
        userId: user.uid,
        name: _nameController.text.trim(),
        totalAmount: total,
        pendingAmount: total,
        monthlyPayment: monthly,
        dueDate: _dueDate,
      );
      await ref.read(debtRepositoryProvider).addDebt(user.uid, debt);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nueva deuda',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.label_outline),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _totalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Importe total (€)',
              prefixIcon: Icon(Icons.euro_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _monthlyController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Cuota mensual (€)',
              prefixIcon: Icon(Icons.calendar_month_outlined),
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.calendar_today_outlined,
                  color: theme.colorScheme.primary, size: 20),
            ),
            title: Text('Fecha de vencimiento',
                style: GoogleFonts.inter(fontSize: 14)),
            trailing: Text(
              '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: _selectDate,
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
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}