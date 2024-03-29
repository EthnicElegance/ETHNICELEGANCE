import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/images/circular_image.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';

import 'package:ethnic_elegance/sharepreferences.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../settings/settings.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? _firstName = '';
  String? _lastName = '';
  String? _email = '';
  String? _phoneNumber = '';
  String? userid;
  Map? data;
  var recdata;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      _fetchSubCategories().then((Map? value) {
        setState(() {
          _firstName = value?['FirstName'];
          _lastName = value?['LastName'];
          _email = value?['Email'];
          _phoneNumber = value?['ContactNo'];
        });
      });
    });
  }

  Future<void> _updateUserData(Map<String, dynamic> newData) async {
    final ref = FirebaseDatabase.instance.ref().child("Project/UserRegister/$userid");
    await ref.update(newData);
  }

  Future<Map?> _fetchSubCategories() async {
    final ref = FirebaseDatabase.instance.ref().child("Project/UserRegister/$userid");
    await ref.once().then((documentSnapshot) => {recdata = documentSnapshot.snapshot.value});

    final documentSnapshot = await ref.once();
    recdata = documentSnapshot.snapshot.value;
    return recdata;

  }

  void _saveChanges() {
    final newData = {
      'FirstName': _firstName,
      'LastName': _lastName,
      'Email': _email,
      'ContactNo': _phoneNumber,
    };
    _updateUserData(newData);

    // Show a snack bar or any other feedback to indicate changes are saved
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved')),
    );
    Get.offAll(()=>const ProfileScreen());
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: EAppBar(showBackArrow: false,leadingIcon: Iconsax.arrow_left, leadingOnPressed: () => Get.offAll(() => const SettingsScreen()), title: const Text('Profile')),

      body: FutureBuilder(
          future: _fetchSubCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            else {

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(ESizes.defaultSpace),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(

                          children: [
                            ECircularImage(
                                image: EHelperFunctions.isDarkMode(context) ? EImages.darkAppLogo : EImages.lightAppLogo, width: 130, height: 130,padding: 0),

                          ],
                        ),
                      ),

                      const SizedBox(height: ESizes.spaceBtwItems / 2),
                      // const Divider(),
                      const SizedBox(height: ESizes.spaceBtwItems),
                      const ESectionHeading(title: 'Profile Information', showActionButton: false),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      for (var entry in snapshot.data!.entries)
                        if(entry.key == 'FirstName')
                          TextFormField(
                            initialValue: _firstName,
                            onChanged: (value) {
                              setState(() {
                                _firstName = value;
                              });
                            },
                            decoration: const InputDecoration(labelText: 'First Name'),
                          ),

                      const SizedBox(height: ESizes.spaceBtwSections),

                      for (var entry in snapshot.data!.entries)
                        if(entry.key == 'LastName')
                          TextFormField(
                            initialValue: _lastName,
                            onChanged: (value) {
                              setState(() {
                                _lastName = value;
                              });
                            },
                            decoration: const InputDecoration(labelText: 'Last Name'),
                          ),


                      const SizedBox(height: ESizes.spaceBtwItems),
                      const Divider(),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      const ESectionHeading( title: 'Personal Information', showActionButton: false),
                      const SizedBox(height: ESizes.spaceBtwItems),


                      for (var entry in snapshot.data!.entries)
                        if(entry.key == 'Email')
                          TextFormField(
                            initialValue: _email,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            decoration: const InputDecoration(labelText: 'Email'),
                          ),

                      const SizedBox(height: ESizes.spaceBtwSections),

                      for (var entry in snapshot.data!.entries)
                        if(entry.key == 'ContactNo')
                          TextFormField(
                            initialValue: _phoneNumber,
                            onChanged: (value) {
                              setState(() {
                                _phoneNumber = value;
                              });
                            },
                            decoration: const InputDecoration(labelText: 'Phone Number'),
                          ),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      const Divider(),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      Center(
                        child: TextButton(
                          onPressed: _saveChanges,
                          child: const Text('Save Changes',
                              style: TextStyle(color: EColors.primary)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}