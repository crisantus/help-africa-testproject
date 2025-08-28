
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:help_africa_test/domain/models/test_model.dart';
import 'package:help_africa_test/presentation/home_page.dart';
import 'package:help_africa_test/presentation/splash_page.dart';
import 'package:help_africa_test/presentation/testdetail_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
         AutoRoute(page: HomeRoute.page),
         AutoRoute(page: TestDetailRoute.page),
       
      ];
}
