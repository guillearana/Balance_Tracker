import 'package:balance_tracker/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location == AppRoutes.analytics) return 0;
    if (location == AppRoutes.budgets) return 1;
    if (location == AppRoutes.main) return 2;
    if (location == AppRoutes.subscriptions) return 3;
    if (location == AppRoutes.groups) return 4;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentIndex = _getCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.bar_chart_outlined,
                  activeIcon: Icons.bar_chart,
                  isActive: currentIndex == 0,
                  onTap: () => context.go(AppRoutes.analytics),
                ),
                _NavItem(
                  icon: Icons.receipt_long_outlined,
                  activeIcon: Icons.receipt_long,
                  isActive: currentIndex == 1,
                  onTap: () => context.go(AppRoutes.budgets),
                ),
                // Botón central destacado
                GestureDetector(
                  onTap: () => context.go(AppRoutes.main),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                _NavItem(
                  icon: Icons.repeat_outlined,
                  activeIcon: Icons.repeat,
                  isActive: currentIndex == 3,
                  onTap: () => context.go(AppRoutes.subscriptions),
                ),
                _NavItem(
                  icon: Icons.group_outlined,
                  activeIcon: Icons.group,
                  isActive: currentIndex == 4,
                  onTap: () => context.go(AppRoutes.groups),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 48,
        height: 56,
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withValues(alpha: 0.4),
          size: 24,
        ),
      ),
    );
  }
}