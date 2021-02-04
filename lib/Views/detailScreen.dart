import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza_delivery_app/Views/HomeScreen.dart';
import 'package:pizza_delivery_app/Views/myCart.dart';
import 'package:pizza_delivery_app/providers/calculations.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailScreen({this.queryDocumentSnapshot});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int cheeseValue = 0;
  int beaconValue = 0;
  int onionValue = 0;
  int totalItems = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatActionButton(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.2,
                0.45,
                0.6,
                0.9,
              ],
              colors: [
                Color(0xFF200B4B),
                Color(0xFF201F22),
                Color(0xFF1A1031),
                Color(0xFF19181F),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              pizzaImage(),
              middleData(),
              footerDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: HomeScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250.0),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.trashAlt,
                color: Colors.red,
              ),
              onPressed: () {
                Provider.of<Calculations>(context, listen: false)
                    .removeAllData();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget pizzaImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: 280,
          child: Container(
            child: Image.network(widget.queryDocumentSnapshot['image']),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget middleData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
                size: 20.0,
              ),
              Text(
                widget.queryDocumentSnapshot['ratings'],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey.shade500,
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 300.0),
              child: Text(
                widget.queryDocumentSnapshot['name'],
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.dollarSign,
                  size: 20.0,
                  color: Colors.cyan,
                ),
                Text(
                  widget.queryDocumentSnapshot['price'].toString(),
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget footerDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 300.0,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                width: 400,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, right: 20, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add more Stuff",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Cheese',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(EvaIcons.minus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .minusCheese();
                                },
                              ),
                              Text(
                                Provider.of<Calculations>(context, listen: true)
                                    .getCheeseValue
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.plus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .addCheese();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Beacon',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(EvaIcons.minus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .minusBecan();
                                },
                              ),
                              Text(
                                Provider.of<Calculations>(context, listen: true)
                                    .getbecanValue
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.plus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .addBeacon();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Onion',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(EvaIcons.minus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .minusOnion();
                                },
                              ),
                              Text(
                                Provider.of<Calculations>(context, listen: true)
                                    .getOnionValue
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.plus),
                                onPressed: () {
                                  Provider.of<Calculations>(context,
                                          listen: false)
                                      .addOnion();
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectSmallSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Provider.of<Calculations>(context, listen: true)
                                .smallTapped
                            ? Colors.lightBlue
                            : Colors.white,
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'S',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectMediumSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Provider.of<Calculations>(context, listen: true)
                                .mediumTapped
                            ? Colors.lightBlue
                            : Colors.white,
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'M',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Calculations>(context, listen: false)
                        .selectLargeSize();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<Calculations>(context, listen: true)
                              .largeTapped
                          ? Colors.lightBlue
                          : Colors.white,
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'L',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget floatActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<Calculations>(context, listen: false)
                .addToCart(context, {
              'image': widget.queryDocumentSnapshot['image'],
              'name': widget.queryDocumentSnapshot['name'],
              'price': widget.queryDocumentSnapshot['price'],
              'onion': Provider.of<Calculations>(context, listen: false)
                  .getOnionValue,
              'beacon': Provider.of<Calculations>(context, listen: false)
                  .getbecanValue,
              'cheese': Provider.of<Calculations>(context, listen: false)
                  .getOnionValue,
              'size': Provider.of<Calculations>(context, listen: false).getSize,
            });
          },
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
              child: Text(
                'Add to cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Stack(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: MyCart(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              },
              child: Icon(Icons.shopping_basket, color: Colors.black),
            ),
            Positioned(
              left: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Text(
                  Provider.of<Calculations>(context, listen: true)
                      .getcartData
                      .toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
