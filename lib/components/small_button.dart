import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.text,
    this.color,
    this.press,
  }) : super(key: key);
  final String text;
  final Function? press;
  final Color? color;
  @override
  Widget build(BuildContext context) {

    return ArgonButton(
      width: getProportionateScreenWidth(120),
      height: getProportionateScreenHeight(30),
      elevation: 7,
      borderRadius: 100.0,
      color: color??kPrimaryColor,
      loader: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const CircularProgressIndicator(color: Colors.white,),
        ),
      ),
      onTap: (startLoading, stopLoading, btnState) async {
        if(btnState == ButtonState.Idle){
          startLoading();
          if(press!=null){
            await press!();
          }
          stopLoading();
        }
      },
      child: Text(text,
        textAlign: TextAlign.center,
        style:TextStyle(
          fontSize: getProportionateScreenWidth(18),
          color: Colors.white,
        )),
    );
  }
}
