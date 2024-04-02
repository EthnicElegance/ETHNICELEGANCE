import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import 'contact_us.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(showBackArrow: true,title: Text('Contact Us',style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        child: ContactUs(),
      ),
    );
  }

}