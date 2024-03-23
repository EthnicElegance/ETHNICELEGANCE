import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/models/rent_order_detail_insert_model.dart';
import 'package:ethnic_elegance/features/shop/models/rent_order_insert_model.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../../payment_configurations.dart' as payment_configurations;
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/rent_checkout_controller.dart';
import '../../home/home.dart';

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class EBillingPaymentSection1 extends StatefulWidget {
  const EBillingPaymentSection1({Key? key}) : super(key: key);

  @override
  State<EBillingPaymentSection1> createState() => _EBillingPaymentSection1State();
}

class _EBillingPaymentSection1State extends State<EBillingPaymentSection1> {
  final controller = Get.put(RentCheckoutController());

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('Project/RentOrder');

  DatabaseReference dbRef1 =
      FirebaseDatabase.instance.ref().child('Project/RentOrderDetail');

  var oId = "";
  String? userId;
  bool? isRetailCustomer;
  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
      _googlePayConfigFuture = PaymentConfiguration.fromAsset(
        'payment/default_google_pay_config.json',
      );
      checkUserType();
    });
  }

  Future<void> checkUserType() async {
    if (mounted) {
      final ref = FirebaseDatabase.instance
          .ref()
          .child("Project/UserRegister/$userId/UserType");
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

  Future<void> onGooglePayResult(paymentResult) async {
    debugPrint(paymentResult.toString());
    late String getKeys;
    List<String> cartId = controller.cartId;
    String orderDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String totalAmount = controller.totalAmount;
    String depositAmount = controller.depositAmount;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      getKeys = prefs.getString('key')!;
      RentOrderInsertModel regobj = RentOrderInsertModel(
        getKeys,
        orderDate,
        totalAmount,
        depositAmount,
        "Pending",
      );
      DatabaseReference newRef = dbRef.push();
      String newOrderKey = newRef.key!;
      newRef.set(regobj.toJson()).then((_) {
        for (var x in cartId) {
          final cartRef =
              FirebaseDatabase.instance.ref().child('Project/RentalCart/$x');
          cartRef.once().then((snapshot) {
            final data = snapshot.snapshot.value as Map<dynamic, dynamic>; // Adjusted type here

            RentOrderDetailInsertModel regobj1 = RentOrderDetailInsertModel(
              newOrderKey,
              data['RentProductId'],
              data['CartQty'],
              data['Size'],
              data['Price'],
              data['TotalPrice'],
            );
            DatabaseReference newRef1 = dbRef1.push();
            newRef1.set(regobj1.toJson());
          });
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Error adding data: $error');
        }
      });

      Get.to(
        () => SuccessScreen(
          image: EImages.successfullyRegisterAnimation,
          title: ETexts.done,
          subTitle: "Your Order has been placed Successfully",
          onPressed: () {
            for (var x in cartId) {
              FirebaseDatabase.instance
                  .ref()
                  .child("Project/RentalCart/$x")
                  .remove()
                  .catchError((error) =>
                  ELoaders.errorSnackBar(
                      title: 'Failed to remove',
                      message: 'Failed to remove item: $error'));
            }
            isRetailCustomer == true ? Get.offAll(() => const HomeScreen1()) : Get.offAll(() => const HomeScreen());
          },
        ),
      );
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ESectionHeading(
          title: 'Payment Method',
          showActionButton: false,

          // buttonTitle: 'Change',
          // onPressed: () {},
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          children: [
            // ERoundedContainer(
            //   width: 60,
            //   height: 35,
            //   backgroundColor: dark ? EColors.light : EColors.white,
            //   padding: const EdgeInsets.all(ESizes.sm),
            //   child: const Image(
            //       image: AssetImage(EImages.googlePay), fit: BoxFit.contain),
            // ),
            const SizedBox(width: ESizes.spaceBtwItems / 2),
            FutureBuilder<PaymentConfiguration>(
              future: _googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                      paymentConfiguration: snapshot.data!,
                      paymentItems: _paymentItems,
                      type: GooglePayButtonType.buy,
                      onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ApplePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(
                        payment_configurations.defaultApplePay,
                      ),
                      paymentItems: _paymentItems,
                      style: ApplePayButtonStyle.black,
                      type: ApplePayButtonType.buy,
                      onPaymentResult: onApplePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
