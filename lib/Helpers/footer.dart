import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza_delivery_app/Views/myCart.dart';

class Footers extends ChangeNotifier {
  Widget floatingActioinButtion(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: MyCart(),
            type: PageTransitionType.rightToLeftWithFade,
          ),
        );
      },
      child: Icon(EvaIcons.shoppingBag),
    );
  }
}
