import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/colors.dart';

class EHomeAppBar extends StatefulWidget {
  const EHomeAppBar({super.key});

  @override
  State<EHomeAppBar> createState() => _EHomeAppBarState();
}

class _EHomeAppBarState extends State<EHomeAppBar> {
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
    });
  }

  Future<Map?> _fetchSubCategories() async {
    final ref =
    FirebaseDatabase.instance.ref().child("Project/UserRegister/$userid");
    await ref.once().then(
            (documentSnapshot) => {recdata = documentSnapshot.snapshot.value});

    print('---------------------------------recdata--------------------------');
    print(recdata);

    return recdata;
  }

  @override
  Widget build(BuildContext context) {
    return EAppBar(
      title: FutureBuilder(
        future: _fetchSubCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Up Comming Data',
                style: TextStyle(fontSize: 10),
              ),
            );
          }
          else {
            // String uname ;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text("EthnicElegance", style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: EColors.grey)),
                for (var entry in snapshot.data!.entries)
                  if(entry.key == 'FirstName' || entry.key == 'LastName')
                Text(entry.value, style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: EColors.white)),

              ],
            );
          }
        }
      ),
      actions: const [
        ECartCounterIcon(iconColor: EColors.white,)
      ],
    );
  }
}
