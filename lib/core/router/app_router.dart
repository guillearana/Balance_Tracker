import 'package:balance_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:balance_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:balance_tracker/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:balance_tracker/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:balance_tracker/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:balance_tracker/features/budgets/presentation/screens/budgets_screen.dart';
import 'package:balance_tracker/features/subscriptions/presentation/screens/subscriptions_screen.dart';
import 'package:balance_tracker/features/debts/presentation/screens/debts_screen.dart';
import 'package:balance_tracker/features/groups/presentation/screens/groups_screen.dart';
import 'package:balance_tracker/features/main/presentation/screens/main_screen.dart';
import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const main = '/';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const addTransaction = '/transactions/add';
  static const budgets = '/budgets';
  static const subscriptions = '/subscriptions';
  static const debts = '/debts';
  static const groups = '/groups';
  static const analytics = '/analytics';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: AppRoutes.main,
    redirect: (context, state) {
      final user = authState.valueOrNull;
      final isLoggedIn = user != null;
      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register;

      // Si está logueado pero sin displayName, esperar (registro en curso)
      if (isLoggedIn &&
          (user.displayName == null || user.displayName!.isEmpty) &&
          isAuthRoute)
        return null;

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && isAuthRoute) return AppRoutes.main;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.transactions,
        builder: (context, state) => const TransactionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (context, state) => const AddTransactionScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.main,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.analytics,
            builder: (context, state) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: AppRoutes.budgets,
            builder: (context, state) => const BudgetsScreen(),
          ),
          GoRoute(
            path: AppRoutes.subscriptions,
            builder: (context, state) => const SubscriptionsScreen(),
          ),
          GoRoute(
            path: AppRoutes.debts,
            builder: (context, state) => const DebtsScreen(),
          ),
          GoRoute(
            path: AppRoutes.groups,
            builder: (context, state) => const GroupsScreen(),
          ),
        ],
      ),
    ],
  );
}
