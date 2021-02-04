import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza_delivery_app/Views/detailScreen.dart';
import '../Services/manageData.dart';
import 'package:provider/provider.dart';

class MiddleHelpers extends ChangeNotifier {
  Widget textFav() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          text: 'Favourite',
          style: TextStyle(
            shadows: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1,
              ),
            ],
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontSize: 36.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' dishes',
              style: TextStyle(
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0,
                  ),
                ],
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataFav(BuildContext context, String collection) {
    return Container(
      height: 300,
      child: FutureBuilder(
        future: Provider.of<ManageData>(context, listen: false)
            .fetchData(collection),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/animation/delivery.json'),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapShot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: DetailScreen(
                        queryDocumentSnapshot: snapShot.data[index],
                      ),
                      type: PageTransitionType.topToBottom,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      color: Colors.white.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightBlueAccent,
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 180,
                                child: snapShot.data[index].data()['image'] ==
                                        null
                                    ? Container()
                                    : Image.network(
                                        snapShot.data[index].data()['image'],
                                        width: 185,
                                        height: 200,
                                      ),
                              ),
                              Positioned(
                                left: 140.0,
                                child: IconButton(
                                  icon: Icon(
                                    EvaIcons.heart,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              snapShot.data[index].data()['name'],
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              snapShot.data[index].data()['category'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.cyan,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow.shade700),
                                    Text(
                                      snapShot.data[index].data()['ratings'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 12,
                                      ),
                                      Text(
                                        snapShot.data[index]
                                            .data()['price']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget textBussiness() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          text: 'Bussinsess',
          style: TextStyle(
            shadows: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1,
              ),
            ],
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: 36.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' Lunch',
              style: TextStyle(
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0,
                  ),
                ],
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataBusiness(BuildContext context, String collection) {
    return Container(
      height: 400,
      child: FutureBuilder(
        future: Provider.of<ManageData>(context, listen: false)
            .fetchData(collection),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/animation/delivery.json'),
            );
          } else {
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(right: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent,
                            blurRadius: 2,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapShot.data[index].data()['name'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  snapShot.data[index].data()['category'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan,
                                  ),
                                ),
                                Text(
                                  snapShot.data[index]
                                      .data()['notPrice']
                                      .toString(),
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(FontAwesomeIcons.dollarSign,
                                        size: 10.0),
                                    Text(
                                      snapShot.data[index]
                                          .data()['price']
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 200,
                              child:
                                  snapShot.data[index].data()['image'] == null
                                      ? Container()
                                      : Image.network(
                                          snapShot.data[index].data()['image'],
                                          // width: 200,
                                          // height: 200,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
