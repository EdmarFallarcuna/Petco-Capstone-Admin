import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../details/details_screen.dart';


class TradeCard extends HookWidget {
  const TradeCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.snapshot
  }) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
  final double width, aspectRetio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments(snapshot: snapshot),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: snapshot.id,
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data()['idPhotoUrl1'],
                      placeholder: (context, url) => const CircularProgressIndicator(color: kPrimaryColor,),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                snapshot.data()['title'],
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Text(snapshot.data()['desire']??'',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.grey,
                      ))),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
