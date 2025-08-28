
import 'package:help_africa_test/core/route/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});