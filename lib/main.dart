

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_africa_test/core/constant/providers.dart';
import 'package:help_africa_test/core/theme/theme.dart';
import 'package:help_africa_test/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter services setup
  runApp(const ProviderScope(child: MyApp())); // Entry point with Riverpod
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider); // Watch current theme state
    final appRouter = ref.watch(appRouterProvider);
    return ScreenUtilInit(
      builder: (context, _) {
        return KeyboardDismissOnTap(
          child: MaterialApp.router(
            title: 'Help Africa Test',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState == ThemeEnums.dark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appRouter.config(),
          ),
        );
      },
    );
  }
}
