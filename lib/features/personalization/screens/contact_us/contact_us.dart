import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    void sendingMails() async {
      var url = Uri.parse("mailto:ethnicelegance06@gmail.com");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    makingPhoneCall() async {
      var url = Uri.parse("tel:9313258783");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          ERoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(ESizes.md),
            backgroundColor: dark ? EColors.black : EColors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Address :',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Text(
                  'Factory House No: 8-9 Navrang Industry, Surat ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                //const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      'Phone : ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        makingPhoneCall();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.zero), // Remove padding
                      ),
                      child: const Text(
                        '+91 9313258783',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            decorationThickness: 2.0),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Text(
                      'Email : ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        sendingMails();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.zero), // Remove padding
                      ),
                      child: const Text(
                        'ethnicelegance06@gmail.com',
                        style: TextStyle(
                          fontSize: 13,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            decorationThickness: 2.0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}