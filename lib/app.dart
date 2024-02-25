import 'package:ethnic_elegance/bindings/general_bindings.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'features/authentication/screens/screens.onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(backgroundColor: EColors.primary,body: Center(child: CircularProgressIndicator(color: EColors.white))),
    );
  }
}
