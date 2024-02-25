import 'package:ethnic_elegance/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class UserReviewCard extends StatelessWidget{
  const UserReviewCard ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final dark = EHelperFunctions.isDarkMode(context);
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Row(
             children: [
               const CircleAvatar(backgroundImage: AssetImage(EImages.userProfileImage1)),
               const SizedBox(width: ESizes.spaceBtwItems),
               Text('Nancy', style: Theme.of(context).textTheme.titleLarge),
             ],
           ),
           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
         ],
       ),
       const SizedBox(height: ESizes.spaceBtwItems),

       ///Review
       Row(
         children: [
           const ERatingBarIndicator(rating: 4),
           const SizedBox(width: ESizes.spaceBtwItems),
           Text('01 Nov, 2023', style: Theme.of(context).textTheme.bodyMedium),
         ],
       ),
       const SizedBox(height: ESizes.spaceBtwItems),
       const ReadMoreText(
         'The user interface of the app is quite intuitive. I was able to navigate and makepurchases seamlessly. Great job!',
         trimLines: 1,
         trimMode: TrimMode.Line,
         trimExpandedText: ' show less',
         trimCollapsedText: ' show more',
         moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: EColors.primary),
         lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: EColors.primary),
       ),
       const SizedBox(height: ESizes.spaceBtwItems),

       /// Company Review
       ERoundedContainer(
         backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
         child: Padding(
           padding: const EdgeInsets.all(ESizes.md),
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("T's Store", style: Theme.of(context).textTheme.titleMedium),
                   Text('02 Nov , 2023', style: Theme.of(context).textTheme.bodyMedium),
                 ],
               ),

               const SizedBox(height: ESizes.spaceBtwItems),
               const ReadMoreText(
                 'The user interface of the app is quite intuitive. I was able to navigate and makepurchases seamlessly. Great job!',
                 trimLines: 1,
                 trimMode: TrimMode.Line,
                 trimExpandedText: ' show less',
                 trimCollapsedText: ' show more',
                 moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: EColors.primary),
                 lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: EColors.primary),
               ),

             ],
           ),
         ),
       ),
       const SizedBox(height: ESizes.spaceBtwSections),
     ],
   );
  }
}