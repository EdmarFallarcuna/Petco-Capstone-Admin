import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends HookWidget {
  const ProductDescription({
    Key? key,
    required this.snapshot,
    this.pressOnSeeMore,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            snapshot.data()['title'],
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
Row(
  children: [
    Expanded(
        child: snapshot.data()['type']=="Sell"?Padding(
          padding: EdgeInsets.only(left:getProportionateScreenWidth(15)),

          child: AutoSizeText(
            "Php${NumberFormat("#,##0.00", "en_US").format(num.tryParse(snapshot.data()['price']??'')??0)}",
            maxLines: 1,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ):const SizedBox()),
    const SizedBox(height: 20,)
  ],
),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: ExpandableText(
            snapshot.data()['description'],
            expandText: '\n\nSee More Detail..',
            collapseText: '\n\n...Show Less',
            maxLines: 4,
            linkColor: kPrimaryColor,
            linkStyle: const TextStyle(
                fontWeight: FontWeight.w600, color: kPrimaryColor),
            animation: true,


          )
          // Text(
          //   snapshot.data()['description'],
          //   maxLines: 3,
          // ),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
