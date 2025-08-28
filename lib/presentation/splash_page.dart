import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:help_africa_test/core/constant/constants.dart';
import 'package:help_africa_test/core/route/app_router.dart';
import 'package:help_africa_test/core/theme/theme.dart';


@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Help Africa'.toUpperCase(),
                  textStyle: context.style.bodyLarge!.copyWith(
                    color: CustomTypography.kWhiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: Duration(milliseconds: 120),
                ),
                 ScaleAnimatedText(
                  'Test Project'.toUpperCase(),
                  textStyle: context.style.bodyLarge!.copyWith(
                    color: CustomTypography.kWhiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  duration: Duration(milliseconds: 2000),
                ),
              ],
              stopPauseOnTap: true,
              repeatForever: false,
              pause: Duration(milliseconds: 500),
              isRepeatingAnimation: false,
              onFinished: (){
                // Navigate to the next screen after the animation finishes
                context.router.replaceAll([HomeRoute()]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
