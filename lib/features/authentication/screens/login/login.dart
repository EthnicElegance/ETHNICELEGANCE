import 'package:ethnic_elegance/common/styles/spacing_styles.dart';
import 'package:ethnic_elegance/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ethnic_elegance/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [

              ELoginHeader(dark: dark),

              const ELoginForm(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                      color: dark ? EColors.darkGrey : EColors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}