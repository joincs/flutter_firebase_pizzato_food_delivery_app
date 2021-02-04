import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza_delivery_app/Services/maps.dart';
import 'package:pizza_delivery_app/Views/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Headers extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(EvaIcons.logOutOutline),
          onPressed: () async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('uid');
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: Login(),
                type: PageTransitionType.leftToRightWithFade,
              ),
            );
          },
        ),
      ],
      centerTitle: true,
      title: Text(
        'Home',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 300.0,
        ),
        child: RichText(
          text: TextSpan(
              text: 'What would you like',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 36.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' to eat?',
                  style: TextStyle(
                    fontSize: 46.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.greenAccent,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget headerMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent,
                    blurRadius: 4.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                color: Colors.grey.shade100,
              ),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'All Food',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Gesture Detector 2 #######
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green,
                    blurRadius: 4.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                color: Colors.grey.shade100,
              ),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'Pasta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Gesture Detector 3 #######
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent,
                    blurRadius: 4.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
                color: Colors.grey.shade100,
              ),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'Pizza',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
