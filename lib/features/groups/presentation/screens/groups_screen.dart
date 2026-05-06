import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/groups/data/repositories/group_provider.dart';
import 'package:balance_tracker/features/groups/data/repositories/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:balance_tracker/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final groupsAsync = ref.watch(userGroupsProvider);
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
                  Text(l10n.groups,
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _showJoinGroupSheet(context, ref),
                        icon: Icon(Icons.group_add_outlined,
                            color: theme.colorScheme.primary),
                        tooltip: 'Unirse a grupo',
                      ),
                      IconButton(
                        onPressed: () => _showCreateGroupSheet(context, ref),
                        icon: Icon(Icons.add_circle_outline,
                            color: theme.colorScheme.primary),
                        tooltip: 'Crear grupo',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: groupsAsync.when(
                data: (groups) {
                  if (groups.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group_outlined,
                              size: 64,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.2)),
                          const SizedBox(height: 16),
                          Text(l10n.noGroupsCreated,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.4))),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () =>
                                _showCreateGroupSheet(context, ref),
                            child: Text(l10n.createGroup),
                          ),
                          TextButton(
                            onPressed: () =>
                                _showJoinGroupSheet(context, ref),
                            child: const Text('Unirse con código'),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Dismissible(
                          key: Key(group['id'] as String),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.delete_outline,
                                color: Colors.white),
                          ),
                          confirmDismiss: (_) async {
                            return await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(l10n.deleteGroup),
                                    content: Text(l10n.deleteGroupConfirm(
                                        group['name'] as String? ?? '')),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: Text(l10n.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: Text(l10n.delete,
                                            style: const TextStyle(
                                                color: Color(0xFFEF4444))),
                                      ),
                                    ],
                                  ),
                                ) ??
                                false;
                          },
                          onDismissed: (_) async {
                            await ref
                                .read(groupRepositoryProvider)
                                .deleteGroup(group['id'] as String);
                          },
                          child: _GroupCard(
                            group: group,
                            onTap: () => _openGroup(context, ref, group),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, __) =>
                    Center(child: Text(l10n.errorLoadingGroups)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateGroupSheet(BuildContext context, WidgetRef ref) {
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
        child: const _CreateGroupSheet(),
      ),
    );
  }

  void _showJoinGroupSheet(BuildContext context, WidgetRef ref) {
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
        child: const _JoinGroupSheet(),
      ),
    );
  }

  void _openGroup(BuildContext context, WidgetRef ref,
      Map<String, dynamic> group) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: _GroupDetailScreen(group: group),
      ),
    ));
  }
}

// ─── JOIN GROUP SHEET ──────────────────────────────────────────────────────

class _JoinGroupSheet extends ConsumerStatefulWidget {
  const _JoinGroupSheet();
  @override
  ConsumerState<_JoinGroupSheet> createState() => _JoinGroupSheetState();
}

class _JoinGroupSheetState extends ConsumerState<_JoinGroupSheet> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    if (_codeController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      final displayName = user.displayName ?? user.email ?? user.uid;
      final result = await ref
          .read(groupRepositoryProvider)
          .joinGroupByCode(
              _codeController.text.trim(), user.uid, displayName);
      if (!mounted) return;
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Código no válido. Comprueba e inténtalo de nuevo.')));
      } else if (result == 'already_member') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ya eres miembro de este grupo.')));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Te has unido al grupo correctamente.')));
        Navigator.of(context).pop();
      }
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unirse a un grupo',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          ),
          const SizedBox(height: 8),
          Text('Introduce el código de invitación que te han compartido.',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
          const SizedBox(height: 20),
          TextField(
            controller: _codeController,
            textCapitalization: TextCapitalization.characters,
            maxLength: 6,
            style: GoogleFonts.inter(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 8),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Código',
              counterText: '',
              prefixIcon: const Icon(Icons.tag),
              hintText: 'AB3X7K',
              hintStyle: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.2)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _join,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('Unirse'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── GROUP CARD ────────────────────────────────────────────────────────────

class _GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  final VoidCallback onTap;
  const _GroupCard({required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  (group['name'] as String? ?? 'G')[0].toUpperCase(),
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(group['name'] as String? ?? '',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface)),
            ),
            Icon(Icons.chevron_right,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}

// ─── CREATE GROUP SHEET ────────────────────────────────────────────────────

class _CreateGroupSheet extends ConsumerStatefulWidget {
  const _CreateGroupSheet();
  @override
  ConsumerState<_CreateGroupSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends ConsumerState<_CreateGroupSheet> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.enterGroupName)));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.userNotAuthenticated)));
        return;
      }
      final displayName = user.displayName ?? user.email ?? user.uid;
      await ref.read(groupRepositoryProvider).createGroup(
          _nameController.text.trim(), user.uid, displayName);
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.newGroup,
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
                labelText: l10n.groupName,
                prefixIcon: const Icon(Icons.group_outlined)),
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
                  : Text(l10n.createGroup),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── GROUP DETAIL SCREEN ───────────────────────────────────────────────────

class _GroupDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> group;
  const _GroupDetailScreen({required this.group});
  @override
  ConsumerState<_GroupDetailScreen> createState() =>
      _GroupDetailScreenState();
}

class _GroupDetailScreenState extends ConsumerState<_GroupDetailScreen> {
  List<Map<String, dynamic>> _expenses = [];
  List<Map<String, dynamic>> _members = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final repo = ref.read(groupRepositoryProvider);
    final groupId = widget.group['id'] as String;
    final members = await repo.getGroupMembers(groupId);
    setState(() {
      _members = members;
      _loading = false;
    });
  }

  String _memberName(String userId) {
    final member = _members.firstWhere(
      (m) => m['userId'] == userId,
      orElse: () => {'displayName': userId},
    );
    return member['displayName'] as String? ?? userId;
  }

  Map<String, double> _calculateBalances() {
    final Map<String, double> balances = {};
    for (final m in _members) {
      balances[m['userId'] as String] = 0.0;
    }
    for (final expense in _expenses) {
      final paidBy = expense['paidBy'] as String;
      final amount = (expense['amount'] as num).toDouble();
      final splits = expense['splits'] as List? ?? [];
      balances[paidBy] = (balances[paidBy] ?? 0) + amount;
      for (final split in splits) {
        final userId = split['userId'] as String;
        final splitAmount = (split['amount'] as num).toDouble();
        balances[userId] = (balances[userId] ?? 0) - splitAmount;
      }
    }
    return balances;
  }

  List<Map<String, dynamic>> _calculateDebts() {
    final balances = _calculateBalances();
    final debtors = balances.entries
        .where((e) => e.value < -0.01)
        .map((e) => {'userId': e.key, 'amount': e.value})
        .toList();
    final creditors = balances.entries
        .where((e) => e.value > 0.01)
        .map((e) => {'userId': e.key, 'amount': e.value})
        .toList();

    final List<Map<String, dynamic>> debts = [];
    int i = 0, j = 0;
    while (i < debtors.length && j < creditors.length) {
      final debtor = Map<String, dynamic>.from(debtors[i]);
      final creditor = Map<String, dynamic>.from(creditors[j]);
      final debtAmount = -(debtor['amount'] as double);
      final creditAmount = creditor['amount'] as double;
      final settled =
          debtAmount < creditAmount ? debtAmount : creditAmount;
      debts.add({
        'from': debtor['userId'],
        'to': creditor['userId'],
        'amount': settled,
      });
      debtors[i]['amount'] = (debtor['amount'] as double) + settled;
      creditors[j]['amount'] = (creditor['amount'] as double) - settled;
      if ((debtors[i]['amount'] as double).abs() < 0.01) i++;
      if ((creditors[j]['amount'] as double) < 0.01) j++;
    }
    return debts;
  }

  void _showInviteCode(BuildContext context) {
    final theme = Theme.of(context);
    final code = widget.group['inviteCode'] as String? ?? '------';
    final groupName = widget.group['name'] as String? ?? 'el grupo';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Código de invitación'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Comparte este código para que otros se unan a "$groupName":',
              style: GoogleFonts.inter(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(code,
                  style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Código copiado al portapapeles')),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('Copiar'),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Share.share(
                      'Únete a mi grupo "$groupName" en BalanceTracker con el código: $code',
                      subject: 'Invitación a grupo BalanceTracker',
                    );
                  },
                  icon: const Icon(Icons.share, size: 18),
                  label: const Text('Compartir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final groupId = widget.group['id'] as String;
    final currencyFormat =
        NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group['name'] as String? ?? '',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            tooltip: 'Invitar miembros',
            onPressed: () => _showInviteCode(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddExpenseSheet(context, groupId),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: ref
                  .read(groupRepositoryProvider)
                  .watchGroupExpenses(groupId),
              builder: (context, snapshot) {
                final expenses = snapshot.data ?? [];
                _expenses = expenses;
                final debts = _calculateDebts();
                final balances = _calculateBalances();

                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // MIEMBROS
                    Text('Miembros (${_members.length})',
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _members.map((m) {
                        final name = m['displayName'] as String? ?? '?';
                        return Chip(
                          avatar: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary
                                .withValues(alpha: 0.15),
                            child: Text(name[0].toUpperCase(),
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary)),
                          ),
                          label: Text(name,
                              style: GoogleFonts.inter(fontSize: 13)),
                          backgroundColor: const Color(0xFFE8EDF4),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // BALANCES
                    if (balances.isNotEmpty) ...[
                      Text(l10n.balances,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      ...balances.entries.map((e) {
                        final isPositive = e.value >= 0;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_memberName(e.key),
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                '${isPositive ? '+' : ''}${currencyFormat.format(e.value)}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isPositive
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFFEF4444),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],

                    // LIQUIDACIONES — diseño mejorado
                    if (debts.isNotEmpty) ...[
                      Text('Liquidaciones',
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      ...debts.map((debt) {
                        final fromName =
                            _memberName(debt['from'] as String);
                        final toName = _memberName(debt['to'] as String);
                        final amount = debt['amount'] as double;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: const Color(0xFFEF4444)
                                    .withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              // Avatar de quien debe
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xFFEF4444)
                                    .withValues(alpha: 0.15),
                                child: Text(
                                  fromName[0].toUpperCase(),
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFEF4444)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: theme
                                                .colorScheme.onSurface),
                                        children: [
                                          TextSpan(
                                              text: fromName,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold)),
                                          const TextSpan(
                                              text: ' debe a '),
                                          TextSpan(
                                              text: toName,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Avatar de quien recibe
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xFF10B981)
                                    .withValues(alpha: 0.15),
                                child: Text(
                                  toName[0].toUpperCase(),
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF10B981)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                currencyFormat.format(amount),
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFEF4444)),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],

                    // GASTOS
                    Text(l10n.expenses,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    if (expenses.isEmpty)
                      Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 32),
                          child: Text(l10n.noExpensesYet,
                              style: GoogleFonts.inter(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.4))),
                        ),
                      )
                    else
                      ...expenses.map((expense) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme
                                  .colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expense['description']
                                                as String? ??
                                            l10n.expense,
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        l10n.paidBy(_memberName(
                                            expense['paidBy']
                                                as String? ??
                                                '')),
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: theme.colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.5),
                                        ),
                                      ),
                                      // Muestra quién participa en el split
                                      if ((expense['splits'] as List?)
                                              ?.isNotEmpty ==
                                          true)
                                        Text(
                                          'Divide entre: ${(expense['splits'] as List).map((s) => _memberName(s['userId'] as String)).join(', ')}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: theme.colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.4),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Text(
                                  currencyFormat
                                      .format(expense['amount']),
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                  ],
                );
              },
            ),
    );
  }

  void _showAddExpenseSheet(BuildContext context, String groupId) {
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
        child: _AddExpenseSheet(groupId: groupId, members: _members),
      ),
    );
  }
}

// ─── ADD EXPENSE SHEET ─────────────────────────────────────────────────────

class _AddExpenseSheet extends ConsumerStatefulWidget {
  final String groupId;
  final List<Map<String, dynamic>> members;
  const _AddExpenseSheet({required this.groupId, required this.members});
  @override
  ConsumerState<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<_AddExpenseSheet> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  String? _paidBy;
  late Set<String> _selectedMembers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider);
    _paidBy = user?.uid;
    // Por defecto todos los miembros participan
    _selectedMembers =
        widget.members.map((m) => m['userId'] as String).toSet();
  }

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_descController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _paidBy == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.completeAllFields)));
      return;
    }
    if (_selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Selecciona al menos un miembro para dividir el gasto.')));
      return;
    }
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return;

    setState(() => _isLoading = true);
    try {
      final selectedList = widget.members
          .where((m) => _selectedMembers.contains(m['userId'] as String))
          .toList();
      final splitAmount = amount / selectedList.length;
      final splits = selectedList
          .map((m) => {'userId': m['userId'], 'amount': splitAmount})
          .toList();

      await ref.read(groupRepositoryProvider).addExpense(widget.groupId, {
        'description': _descController.text.trim(),
        'amount': amount,
        'paidBy': _paidBy,
        'splits': splits,
      });
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;
    final splitAmount = _selectedMembers.isNotEmpty
        ? amount / _selectedMembers.length
        : 0.0;
    final currencyFormat =
        NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.addExpense,
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
                labelText: l10n.description,
                prefixIcon: const Icon(Icons.notes_outlined)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
                labelText: l10n.amount,
                prefixIcon: const Icon(Icons.euro_outlined)),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _paidBy,
            decoration: const InputDecoration(
              labelText: 'Pagado por',
              prefixIcon: Icon(Icons.person_outline),
            ),
            items: widget.members.map((m) {
              final uid = m['userId'] as String;
              final name = m['displayName'] as String? ?? uid;
              return DropdownMenuItem<String>(
                  value: uid, child: Text(name));
            }).toList(),
            onChanged: (val) => setState(() => _paidBy = val),
          ),
          const SizedBox(height: 16),
          // SELECTOR DE PARTICIPANTES
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Divide entre:',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 8),
          ...widget.members.map((m) {
            final uid = m['userId'] as String;
            final name = m['displayName'] as String? ?? uid;
            final isSelected = _selectedMembers.contains(uid);
            return CheckboxListTile(
              value: isSelected,
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    _selectedMembers.add(uid);
                  } else {
                    _selectedMembers.remove(uid);
                  }
                });
              },
              title: Text(name, style: GoogleFonts.inter(fontSize: 14)),
              subtitle: isSelected && amount > 0
                  ? Text(currencyFormat.format(splitAmount),
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500))
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
            );
          }),
          const SizedBox(height: 16),
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
                  : Text(l10n.save),
            ),
          ),
        ],
      ),
    );
  }
}