import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/personalization/screens/rent_rules/ruleslist.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('Rules for Renting',style: Theme.of(context).textTheme.headlineMedium,)),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        child: ERulesList(),
      ),
    );
  }

}