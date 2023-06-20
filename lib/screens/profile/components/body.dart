import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../size_config.dart';
import 'profile_menu.dart';

class Body extends HookWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final name = useState<String>('');

    useEffect(
          () {
        String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
        final subscription = FirebaseFirestore.instance.collection('admin').doc(uid).snapshots().listen((event) {
          name.value = event.data()?['name']??'';
        });
        return subscription.cancel;
      },
      // when the stream changes, useEffect will call the callback again.
      [],
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Admin Profile",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            "Hi, ${name.value}",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(27),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.exit_to_app,
            press: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
