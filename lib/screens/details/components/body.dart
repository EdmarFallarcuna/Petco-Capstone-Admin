import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';


import '../../../components/default_button.dart';
import '../../../components/notification_body.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'user_description.dart';

class Body extends StatelessWidget {

  const Body({Key? key, required this.snapshot}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(snapshot: snapshot),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                snapshot: snapshot,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          // margin: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
          // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              UserDescription(
                transactionID: snapshot.id,
                ownerID: snapshot.data()['owner'],
                petName: snapshot.data()['title'],
                petImage: snapshot.data()['idPhotoUrl1'],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const SizedBox(width: 20,),
            Expanded(
              child: Center(
                child: DefaultButton(
                  text: "Approved",
                  press: () async {
                    final myContext = context;
                    final navigator = Navigator.of(context);
                    await FirebaseFirestore.instance.collection('listing').doc(snapshot.id).update({
                      "status": "available",
                    });
                    InAppNotification.show(
                      child: const NotificationBody(
                        msg: "Successfully update the status",
                      ),
                      context: myContext,
                    );
                    navigator.pop();
                  },
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Center(
                child: DefaultButton(
                  text: "Reject",
                  color: Colors.red,
                  press: () async {
                    final myContext = context;
                    final navigator = Navigator.of(context);
                    await FirebaseFirestore.instance.collection('listing').doc(snapshot.id).update({
                      "status": "reject",
                    });
                    InAppNotification.show(
                      child: const NotificationBody(
                        msg: "Successfully update the status",
                      ),
                      context: myContext,
                    );
                    navigator.pop();
                  },
                ),
              ),
            ),
            const SizedBox(width: 20,),
          ],
        ),

      ],
    );
  }
}
