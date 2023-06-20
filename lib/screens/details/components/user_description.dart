import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class UserDescription extends StatelessWidget {
  const UserDescription({
    Key? key,
    required this.ownerID, required this.transactionID, required this.petName, required this.petImage
  }) : super(key: key);

  final String ownerID;
  final String transactionID;
  final String petName;
  final String petImage;

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text(
            "An Unknown error has occurred.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(
            "An Unknown error has occurred.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(20),
                  ),
                  const CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/petco-e7fc9.appspot.com/o/user_res%2FsLXwBwQoo8fKy0N5N1z1PbTOvZ93%2F4f1d1b7f-d644-4570-8c8d-a87cbf88a3b7.jpg?alt=media&token=80abde8f-0b79-4124-b5b0-c2651ea1d04f"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        const Text(
                          "Owner",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text(
                          "${data['firstName']} ${data['lastName']}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          "${data['streetAddress']} ${data['city']} ${data['province']}",
                          maxLines: 3,
                        ),
                        RatingBarIndicator(
                          rating: (data['rating']??0)/(data['numberOfRating']??1),
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: getProportionateScreenWidth(20),
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),



            ],
          );

        }

        return const CircularProgressIndicator(color: kPrimaryColor,);
      },
    );

  }
}
