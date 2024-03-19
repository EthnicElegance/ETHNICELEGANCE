import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import 'models/faqmodel.dart';

class EFaqList extends StatefulWidget {
  const EFaqList({super.key});

  @override
  State<EFaqList> createState() => _EFaqListState();
}

class _EFaqListState extends State<EFaqList> {
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('Project/FAQs').onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Map<dynamic, dynamic> map = snapshot.data
              .snapshot
              .value;
          List<FaqModel> faqlist = [];
          faqlist.clear();
          map.forEach((dynamic, v) =>
              faqlist.add(FaqModel(
                v["question"],
                v["answer"],
              )));
          if (map.isEmpty) {
            return const Center(
              child: Text(
                'Up Coming Data',
                style: TextStyle(fontSize: 10),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: faqlist.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: ESizes.spaceBtwItems),
            itemBuilder: (_, index) => ERoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(ESizes.md),
                backgroundColor: dark ? EColors.dark : EColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: ESizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(faqlist[index].question,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: ESizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(faqlist[index].answer,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 1.5),
          );
        }
      },
    );
  }
}
