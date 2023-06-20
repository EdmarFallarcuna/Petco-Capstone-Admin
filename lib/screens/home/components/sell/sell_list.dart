import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'sell_card.dart';



class SellList extends StatelessWidget {
  const SellList({Key? key, required this.list, required this.search}) : super(key: key);
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> list;
  final String search;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(10)),
        Expanded(
          child:list.isEmpty? const Text(
            "Sorry there is no list for now",
            style: TextStyle(color: kPrimaryColor),
          ): MasonryGridView.count(
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            crossAxisCount: 2,
            mainAxisSpacing:16,
            crossAxisSpacing: 0,
            itemBuilder: (context, index) {

                return SellCard(snapshot: list.elementAt(index));


            },
          ),
        )
      ],
    );
  }
}
