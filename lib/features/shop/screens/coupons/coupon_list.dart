import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/controllers/coupon_controller.dart';
import 'package:ethnic_elegance/features/shop/screens/checkout/checkout.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/coupon_model.dart';

class ECouponList extends StatefulWidget {
  const ECouponList({Key? key, required this.showIcon}) : super(key: key);
  final bool showIcon;

  @override
  State<ECouponList> createState() => _ECouponListState();
}

class _ECouponListState extends State<ECouponList> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponController());
    final dark = EHelperFunctions.isDarkMode(context);
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child('Project/Coupon').onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 1.5,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(
              child: Text(
                'No Coupons Available',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            Map<dynamic, dynamic> orderData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<CouponModel> couponList = [];

            orderData.forEach((key, value) {
              if (value != null) {
                DateTime expirationDate = DateFormat('yyyy-MM-dd').parse(value['Expire_DateTime']);
                if (expirationDate.isAfter(DateTime.now())) {
                  couponList.add(CouponModel(
                    key.toString(),
                    value['Amount'],
                    value['Coupon_discount'],
                    value['Coupon_name'],
                    value['Expire_DateTime'],
                    value['photo'],
                  ));
                }
              }
            });

            return ListView.separated(
              shrinkWrap: true,
              itemCount: couponList.length,
              separatorBuilder: (_, __) => const SizedBox(height: ESizes.spaceBtwItems),
              itemBuilder: (_, index) => ERoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ESizes.md),
                backgroundColor: dark ? EColors.dark : EColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Iconsax.ticket_discount),
                        const SizedBox(width: ESizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                couponList[index].couponname,
                                style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: EColors.info,
                                  fontWeightDelta: 1,
                                ),
                              ),
                              Text(
                                "${couponList[index].coupondiscount} OFF",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        widget.showIcon
                            ? IconButton(
                          onPressed: () {
                            controller.couponName.text = couponList[index].couponname;
                            ELoaders.successSnackBar(
                              title: 'Coupon Added Successfully',
                              message: 'You get ${couponList[index].coupondiscount}',
                            );
                            Get.to(() => const CheckOutScreen());
                          },
                          icon: const Icon(Iconsax.add_square, size: ESizes.iconMd),
                        )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.tag),
                              const SizedBox(width: ESizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    Text(
                                      '₹${couponList[index].amount}',
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: ESizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expire Date',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    Text(
                                      couponList[index].expiredate,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
