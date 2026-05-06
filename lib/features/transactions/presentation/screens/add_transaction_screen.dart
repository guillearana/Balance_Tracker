import 'package:balance_tracker/core/utils/category_translator.dart';
import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/categories/data/repositories/category_provider.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_provider.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';
import 'package:balance_tracker/core/providers/currency_provider.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  final TransactionModel? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  TransactionType _type = TransactionType.expense;
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final t = widget.transaction!;
      _amountController.text = t.amount.toStringAsFixed(2).replaceAll('.', ',');
      _noteController.text = t.note ?? '';
      _type = t.type;
      _selectedCategoryId = t.categoryId;
      _selectedDate = t.date;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.selectCategory)));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      final transaction = TransactionModel(
        id: _isEditing ? widget.transaction!.id : const Uuid().v4(),
        userId: user.uid,
        amount: double.parse(_amountController.text.replaceAll(',', '.')),
        type: _type,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        createdAt: _isEditing ? widget.transaction!.createdAt : DateTime.now(),
        note: _noteController.text.isEmpty ? null : _noteController.text,
      );
      if (_isEditing) {
        await ref
            .read(transactionRepositoryProvider)
            .updateTransaction(user.uid, transaction);
      } else {
        await ref
            .read(transactionRepositoryProvider)
            .addTransaction(user.uid, transaction);
      }
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

  IconData _getCategoryIcon(String iconName) {
    const iconMap = {
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'sports_esports': Icons.sports_esports,
      'favorite': Icons.favorite,
      'home': Icons.home,
      'checkroom': Icons.checkroom,
      'school': Icons.school,
      'category': Icons.category,
      'work': Icons.work,
      'savings': Icons.savings,
      'card_giftcard': Icons.card_giftcard,
      'account_balance': Icons.account_balance,
      'attach_money': Icons.attach_money,
      'trending_up': Icons.trending_up,
    };
    return iconMap[iconName] ?? Icons.category;
  }

  Color _parseColor(String color) {
    if (color.startsWith('#')) {
      final hex = color.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    }
    return Color(int.parse(color));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final categoriesAsync = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar transacción' : l10n.newTransaction,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final toggleWidth = constraints.maxWidth;
                final isExpense = _type == TransactionType.expense;
                return Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        alignment: isExpense
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          width: toggleWidth / 2,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isExpense
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _type = TransactionType.expense,
                              ),
                              child: Center(
                                child: Text(
                                  l10n.expense,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: isExpense
                                        ? Colors.white
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _type = TransactionType.income,
                              ),
                              child: Center(
                                child: Text(
                                  l10n.income,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: !isExpense
                                        ? Colors.white
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: '0,00',
                hintStyle: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                prefixText: '${ref.watch(currencyNotifierProvider)} ',
                prefixStyle: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                filled: false,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.enterAmount;
                final val = double.tryParse(v.replaceAll(',', '.'));
                if (val == null || val <= 0) return l10n.invalidAmount;
                return null;
              },
            ),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              l10n.category,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 12),
            categoriesAsync.when(
              data: (categories) {
                final filtered = categories
                    .where((c) => c.type == _type.name)
                    .toList();
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filtered.map((cat) {
                    final isSelected = _selectedCategoryId == cat.id;
                    final catColor = _parseColor(cat.color);
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategoryId = cat.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? catColor
                              : theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: catColor.withValues(alpha: 0.3),
                                  width: 1.5,
                                ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getCategoryIcon(cat.icon),
                              size: 16,
                              color: isSelected ? Colors.white : catColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              CategoryTranslator.translate(context, cat.name),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => Text(l10n.errorLoadingCategories),
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              title: Text(
                l10n.date,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: _selectDate,
            ),
            const Divider(),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.noteOptional,
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
            ),
            const SizedBox(height: 32),
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
                    : Text(_isEditing ? 'Actualizar' : l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
