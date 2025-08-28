// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [TestDetailPage]
class TestDetailRoute extends PageRouteInfo<TestDetailRouteArgs> {
  TestDetailRoute({
    Key? key,
    required Result item,
    List<PageRouteInfo>? children,
  }) : super(
         TestDetailRoute.name,
         args: TestDetailRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'TestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestDetailRouteArgs>();
      return TestDetailPage(key: args.key, item: args.item);
    },
  );
}

class TestDetailRouteArgs {
  const TestDetailRouteArgs({this.key, required this.item});

  final Key? key;

  final Result item;

  @override
  String toString() {
    return 'TestDetailRouteArgs{key: $key, item: $item}';
  }
}
