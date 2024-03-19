
import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/personalization/screens/FAQs/faqlist.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('FAQs',style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        child: EFaqList(),
      ),
    );
  }

}