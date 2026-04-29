import 'package:balance_tracker/features/auth/providers/auth_provider.dart';
import 'package:balance_tracker/features/subscriptions/data/repositories/subscription_repository.dart';
import 'package:balance_tracker/features/subscriptions/domain/models/subscription_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_provider.g.dart';

@riverpod
SubscriptionRepository subscriptionRepository(SubscriptionRepositoryRef ref) {
  return SubscriptionRepository();
}

@riverpod
Stream<List<SubscriptionModel>> subscriptions(SubscriptionsRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  return ref
      .watch(subscriptionRepositoryProvider)
      .watchActiveSubscriptions(user.uid);
}