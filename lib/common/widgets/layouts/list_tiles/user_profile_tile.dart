import 'package:ethnic_elegance/features/personalization/screens/profile/profile1.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/personalization/screens/profile/profile.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../images/rounded_image.dart';

class EUerProfileTitle extends StatefulWidget {
  const EUerProfileTitle({super.key});

  @override
  State<EUerProfileTitle> createState() => _EUerProfileTitleState();
}

class _EUerProfileTitleState extends State<EUerProfileTitle> {

  String? userid;
  Map? data;
  var recdata;
  bool? isRetailCustomer;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      checkUserType();
    });
  }
  Future<void> checkUserType() async {
    if (mounted) {
      final ref = FirebaseDatabase.instance
          .ref()
          .child("Project/UserRegister/$userid/UserType");
      final snapshot = await ref.once();

      if (snapshot.snapshot.value == "Retail Customer") {
        setState(() {
          isRetailCustomer = true;
        });
      } else {
        setState(() {
          isRetailCustomer = false;
        });
      }
    }
  }

  Future<Map?> _fetchSubCategories() async {
    final ref =
    FirebaseDatabase.instance.ref().child("Project/UserRegister/$userid");
    await ref.once().then(
            (documentSnapshot) => {recdata = documentSnapshot.snapshot.value});
    return recdata;
  }

  @override
  Widget build(BuildContext context) {
    var username = "";
    return FutureBuilder(
      future: _fetchSubCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text(
              'Up Coming Data',
              style: TextStyle(fontSize: 10),
            ),
          );
        }
        else {
          for (var entry in snapshot.data!.entries) {
            if (entry.key == 'FirstName' || entry.key == 'LastName') {
              username += "${entry.value} ";
            }
          }
          return Column(
            children: [

              ListTile(
                leading: ERoundedImage(
                  imageUrl: EHelperFunctions.isDarkMode(context) ? EImages.darkAppLogo : EImages.lightAppLogo,
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(0),
                ),
                title: Text(username, style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: EColors.white)),

                trailing: IconButton(
                    onPressed: () => isRetailCustomer == true ? Get.to(() => const ProfileScreen1()) : Get.to(() => const ProfileScreen()),
                    icon: const Icon(Iconsax.edit, color: EColors.white)),
              ),
            ],
          );
        }
      }
    );
  }
}