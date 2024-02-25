import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/images/circular_image.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const EAppBar(showBackArrow: true, title: Text('Profile')),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(

                  children: [
                  const ECircularImage(image: EImages.user,width: 80,height: 80),
                  TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),

                 ],
               ),
              ),

              const SizedBox(height: ESizes.spaceBtwItems/2),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),
              const ESectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(onPressed: () {}, title: 'Name', value: 'Ethnic Elegance'),
              EProfileMenu(onPressed: () {}, title: 'Username', value: 'Ethnic Elegance'),

              const SizedBox(height: ESizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              const ESectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(onPressed: () {}, title: 'User ID', value: '45689'),
              EProfileMenu(onPressed: () {}, title: 'E-mail', value: 'Ethnic Elegance'),
              EProfileMenu(onPressed: () {}, title: 'Phone Number', value: '1234567899'),
              EProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              EProfileMenu(onPressed: () {}, title: 'Date of Birth', value: '10 Oct,1994'),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),
              
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Close Account',style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}