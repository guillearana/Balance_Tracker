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
import 'package:balance_tracker/core/providers/currency_provider.dart';

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
                  Text(
                    l10n.groups,
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _showJoinGroupSheet(context, ref),
                          icon: Icon(
                            Icons.group_add_outlined,
                            color: theme.colorScheme.onSurface,
                            size: 18,
                          ),
                          tooltip: 'Unirse a grupo',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _showCreateGroupSheet(context, ref),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          tooltip: 'Crear grupo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Text(
                'Tus grupos compartidos',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: groupsAsync.when(
                data: (groups) {
                  if (groups.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              Icons.group_outlined,
                              size: 36,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noGroupsCreated,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Crea un grupo o únete con un código',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () =>
                                    _showJoinGroupSheet(context, ref),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onSurface,
                                  side: BorderSide(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.12),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Unirse con código'),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () =>
                                    _showCreateGroupSheet(context, ref),
                                child: Text(l10n.createGroup),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Dismissible(
                          key: Key(group['id'] as String),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFEF4444,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(
                                  0xFFEF4444,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                          confirmDismiss: (_) async {
                            return await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(l10n.deleteGroup),
                                    content: Text(
                                      l10n.deleteGroupConfirm(
                                        group['name'] as String? ?? '',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: Text(l10n.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: Text(
                                          l10n.delete,
                                          style: const TextStyle(
                                            color: Color(0xFFEF4444),
                                          ),
                                        ),
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
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                ),
                error: (e, __) => Center(
                  child: Text(
                    l10n.errorLoadingGroups,
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: const _JoinGroupSheet(),
      ),
    );
  }

  void _openGroup(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> group,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProviderScope(
          parent: ProviderScope.containerOf(context),
          child: _GroupDetailScreen(group: group),
        ),
      ),
    );
  }
}

// ─── GROUP CARD ────────────────────────────────────────────────────────────

class _GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  final VoidCallback onTap;
  const _GroupCard({required this.group, required this.onTap});

  Color _avatarColor(String name) {
    const colors = [
      Color(0xFF8B5CF6),
      Color(0xFF3B82F6),
      Color(0xFFEC4899),
      Color(0xFF10B981),
      Color(0xFFF59E0B),
      Color(0xFFEF4444),
    ];
    return colors[name.codeUnits.first % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = group['name'] as String? ?? 'G';
    final color = _avatarColor(name);
    final memberCount = (group['memberIds'] as List?)?.length ?? 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  name[0].toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$memberCount miembro${memberCount == 1 ? '' : 's'}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
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
          .joinGroupByCode(_codeController.text.trim(), user.uid, displayName);
      if (!mounted) return;
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código no válido. Comprueba e inténtalo de nuevo.'),
          ),
        );
      } else if (result == 'already_member') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ya eres miembro de este grupo.')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Te has unido al grupo correctamente.')),
        );
        Navigator.of(context).pop();
      }
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
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Unirse a un grupo',
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
          const SizedBox(height: 8),
          Text(
            'Introduce el código de invitación que te han compartido.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _codeController,
            textCapitalization: TextCapitalization.characters,
            maxLength: 6,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
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
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Unirse'),
            ),
          ),
        ],
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.enterGroupName)));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.userNotAuthenticated)));
        return;
      }
      final displayName = user.displayName ?? user.email ?? user.uid;
      await ref
          .read(groupRepositoryProvider)
          .createGroup(_nameController.text.trim(), user.uid, displayName);
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.newGroup,
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
              labelText: l10n.groupName,
              prefixIcon: const Icon(Icons.group_outlined),
            ),
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
  ConsumerState<_GroupDetailScreen> createState() => _GroupDetailScreenState();
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

  Color _avatarColor(String name) {
    const colors = [
      Color(0xFF8B5CF6),
      Color(0xFF3B82F6),
      Color(0xFFEC4899),
      Color(0xFF10B981),
      Color(0xFFF59E0B),
      Color(0xFFEF4444),
    ];
    return colors[name.codeUnits.first % colors.length];
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
      final settled = debtAmount < creditAmount ? debtAmount : creditAmount;
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                code,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                ),
              ),
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
                        content: Text('Código copiado al portapapeles'),
                      ),
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
    final currentUser = ref.read(currentUserProvider);
    final isAdmin = widget.group['createdBy'] == currentUser?.uid;
    final currencyFormat = NumberFormat.currency(
      locale: 'es_ES',
      symbol: ref.watch(currencyNotifierProvider),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grupo',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                letterSpacing: 0.5,
              ),
            ),
            Text(
              widget.group['name'] as String? ?? '',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.person_add_outlined,
                color: theme.colorScheme.onSurface,
                size: 18,
              ),
              onPressed: () => _showInviteCode(context),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () => _showAddExpenseSheet(context, groupId),
            ),
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
                final totalGasto = expenses.fold<double>(
                  0,
                  (sum, e) => sum + (e['amount'] as num).toDouble(),
                );

                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
                  children: [
                    // SUMMARY CARD
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1E40AF),
                            theme.colorScheme.primary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 28,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total del grupo',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currencyFormat.format(totalGasto),
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.receipt_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${expenses.length} gastos',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),

                    // MIEMBROS
                    _SectionHead(
                      title: 'Miembros',
                      count: '${_members.length}',
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _members.map((m) {
                          final name = m['displayName'] as String? ?? '?';
                          final color = _avatarColor(name);
                          final uid = m['userId'] as String;
                          final isMemberAdmin =
                              widget.group['createdBy'] == uid;
                          final canRemove = isAdmin && uid != currentUser?.uid;

                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: EdgeInsets.fromLTRB(
                              6,
                              6,
                              canRemove ? 4 : 14,
                              6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: color,
                                  child: Text(
                                    name[0].toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  name,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                if (isMemberAdmin) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      'admin',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                if (canRemove) ...[
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('Eliminar miembro'),
                                          content: Text(
                                            '¿Eliminar a $name del grupo?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(false),
                                              child: const Text('Cancelar'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(true),
                                              child: const Text(
                                                'Eliminar',
                                                style: TextStyle(
                                                  color: Color(0xFFEF4444),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (confirm == true && mounted) {
                                        await ref
                                            .read(groupRepositoryProvider)
                                            .removeMember(groupId, uid);
                                        await _loadData();
                                      }
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFEF4444,
                                        ).withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: const Color(
                                          0xFFEF4444,
                                        ).withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // BALANCES
                    if (balances.isNotEmpty) ...[
                      _SectionHead(
                        title: 'Balances',
                        count: 'Neto por persona',
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: balances.length > 2
                            ? 3
                            : balances.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.85,
                        children: balances.entries.map((e) {
                          final isPos = e.value >= 0;
                          final name = _memberName(e.key);
                          final color = _avatarColor(name);
                          final amountColor = isPos
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444);
                          final pillBg = isPos
                              ? const Color(0xFF10B981).withValues(alpha: 0.14)
                              : const Color(0xFFEF4444).withValues(alpha: 0.12);
                          return Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: color,
                                  child: Text(
                                    name[0].toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  name,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${isPos ? '+' : ''}${currencyFormat.format(e.value)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: amountColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: pillBg,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    isPos ? 'a favor' : 'debe',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: amountColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 26),
                    ],

                    // LIQUIDACIONES
                    if (debts.isNotEmpty) ...[
                      _SectionHead(
                        title: 'Liquidaciones',
                        count: '${debts.length} pendientes',
                      ),
                      const SizedBox(height: 12),
                      ...debts.map((debt) {
                        final fromName = _memberName(debt['from'] as String);
                        final toName = _memberName(debt['to'] as String);
                        final amount = debt['amount'] as double;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 52,
                                height: 32,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor: const Color(
                                          0xFFEF4444,
                                        ).withValues(alpha: 0.18),
                                        child: Text(
                                          fromName[0].toUpperCase(),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFEF4444),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                theme.scaffoldBackgroundColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: const Color(
                                            0xFF10B981,
                                          ).withValues(alpha: 0.18),
                                          child: Text(
                                            toName[0].toUpperCase(),
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF10B981),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pago pendiente',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: fromName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const TextSpan(text: ' debe a '),
                                          TextSpan(
                                            text: toName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                currencyFormat.format(amount),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFEF4444),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 26),
                    ],

                    // GASTOS
                    _SectionHead(
                      title: l10n.expenses,
                      count: '${expenses.length} en total',
                    ),
                    const SizedBox(height: 12),
                    if (expenses.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Text(
                            l10n.noExpensesYet,
                            style: GoogleFonts.inter(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      ...expenses.map(
                        (expense) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.receipt_outlined,
                                  color: theme.colorScheme.primary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expense['description'] as String? ??
                                          l10n.expense,
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Pagado por ${_memberName(expense['paidBy'] as String? ?? '')}',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.6),
                                      ),
                                    ),
                                    if ((expense['splits'] as List?)
                                            ?.isNotEmpty ==
                                        true)
                                      Text(
                                        'Divide entre: ${(expense['splits'] as List).map((s) => _memberName(s['userId'] as String)).join(', ')}',
                                        style: GoogleFonts.inter(
                                          fontSize: 11.5,
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.4),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                currencyFormat.format(expense['amount']),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
    if (user != null && widget.members.any((m) => m['userId'] == user.uid)) {
      _paidBy = user.uid;
    } else if (widget.members.isNotEmpty) {
      _paidBy = widget.members.first['userId'] as String;
    }
    _selectedMembers = widget.members.map((m) => m['userId'] as String).toSet();
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.completeAllFields)));
      return;
    }
    if (_selectedMembers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecciona al menos un miembro para dividir el gasto.',
          ),
        ),
      );
      return;
    }
    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
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
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;
    final splitAmount = _selectedMembers.isNotEmpty
        ? amount / _selectedMembers.length
        : 0.0;
    final currencyFormat = NumberFormat.currency(
      locale: 'es_ES',
      symbol: ref.watch(currencyNotifierProvider),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.addExpense,
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
          const SizedBox(height: 20),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: l10n.description,
              prefixIcon: const Icon(Icons.notes_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l10n.amount,
              prefixIcon: const Icon(Icons.payments_outlined),
            ),
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
              return DropdownMenuItem<String>(value: uid, child: Text(name));
            }).toList(),
            onChanged: (val) => setState(() => _paidBy = val),
          ),
          const SizedBox(height: 20),
          Text(
            'Divide entre:',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: widget.members.asMap().entries.map((entry) {
                final idx = entry.key;
                final m = entry.value;
                final uid = m['userId'] as String;
                final name = m['displayName'] as String? ?? uid;
                final isSelected = _selectedMembers.contains(uid);
                final isLast = idx == widget.members.length - 1;
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedMembers.remove(uid);
                          } else {
                            _selectedMembers.add(uid);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface.withValues(
                                          alpha: 0.3,
                                        ),
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                name,
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                            ),
                            if (isSelected && amount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  currencyFormat.format(splitAmount),
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.08,
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
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
                  : Text(
                      l10n.save,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SECTION HEAD ──────────────────────────────────────────────────────────

class _SectionHead extends StatelessWidget {
  final String title;
  final String count;
  const _SectionHead({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          count,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
