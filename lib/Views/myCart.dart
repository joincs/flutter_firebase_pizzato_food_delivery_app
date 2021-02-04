import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizza_delivery_app/Services/manageData.dart';
import 'package:pizza_delivery_app/Services/maps.dart';
import 'package:pizza_delivery_app/Views/splash_screen.dart';
import 'package:pizza_delivery_app/providers/authentication.dart';
import 'package:pizza_delivery_app/providers/calculations.dart';
import 'package:pizza_delivery_app/providers/payment.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'HomeScreen.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Razorpay razorpay;
  int total = 420;
  int price = 400;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false)
            .handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlePymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false)
            .handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  Future checkMeOut() async {
    var options = {
      'key': 'rzp_test_6cRe7Za4GvTeP6',
      'amount': total,
      'name': Provider.of<Authentication>(context, listen: false)
                  .getUserEmail ==
              null
          ? userEmail
          : Provider.of<Authentication>(context, listen: false).getUserEmail,
      'description': 'Payment',
      'prefill': {
        'contact': '',
        'email':
            Provider.of<Authentication>(context, listen: false).getUserEmail
      },
      'external': {
        'wallet': ['paytm'],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context),
                headerText(),
                cartData(),
                Container(
                  height: 280,
                  width: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/space.png'),
                    ),
                  ),
                )
              ],
            ),
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
              color: Colors.white,
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
                Provider.of<ManageData>(context, listen: false)
                    .deleteData(context);
                Provider.of<Calculations>(context, listen: false).cartData = 0;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget headerText() {
    return Column(
      children: [
        Text(
          'Your,',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 22.0,
          ),
        ),
        Text(
          'CART,',
          style: TextStyle(
            color: Colors.white,
            fontSize: 46.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("myorders").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/animation/delivery.json'),
            );
          } else {
            return new ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return GestureDetector(
                  onLongPress: () {
                    placeOrder(context, documentSnapshot);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent,
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    height: 200,
                    width: 400,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SizedBox(
                            child: Image.network(
                              documentSnapshot.data()['image'],
                              width: 185,
                              height: 200,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              documentSnapshot.data()['name'],
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'Price: ${documentSnapshot.data()['price'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 21.0,
                              ),
                            ),
                            Text(
                              'Onion: ${documentSnapshot.data()['onion'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Beacon: ${documentSnapshot.data()['beacon'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Cheese: ${documentSnapshot.data()['cheese'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            CircleAvatar(
                              child: Text(
                                documentSnapshot.data()['size'],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  placeOrder(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  color: Colors.white,
                  thickness: 4,
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                          "Time:${Provider.of<PaymentHelper>(context, listen: true).deliveryTiming.format(context)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Text(
                          "Location:${Provider.of<GenerateMaps>(context, listen: true).getMainAddress}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      Provider.of<PaymentHelper>(context, listen: false)
                          .selectTime(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.lightBlueAccent,
                    onPressed: () {
                      Provider.of<PaymentHelper>(context, listen: false)
                          .selectLocation(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.mapPin,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.lightGreenAccent,
                    onPressed: () async {
                      await checkMeOut().whenComplete(() {
                        Provider.of<PaymentHelper>(context, listen: false)
                            .showCheckoutButtonMethod();
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.paypal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Provider.of<PaymentHelper>(context, listen: false)
                      .showCheckoutButtonMethod()
                  ? MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('adminCollection')
                            .add({
                          'username': Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserEmail ==
                                  null
                              ? userEmail
                              : Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserEmail,
                          'image': documentSnapshot.data()['image'],
                          'pizza': documentSnapshot.data()['name'],
                          'price': documentSnapshot.data()['price'],
                          'time':
                              Provider.of<PaymentHelper>(context, listen: false)
                                  .deliveryTiming
                                  .format(context),
                          'location':
                              Provider.of<GenerateMaps>(context, listen: false)
                                  .getMainAddress,
                          'size': documentSnapshot.data()['size'],
                          'onion': documentSnapshot.data()['onion'],
                          'cheese': documentSnapshot.data()['cheese'],
                          'beacon': documentSnapshot.data()['beacon'],
                        });
                      },
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Color(0xFF191531),
          ),
        );
      },
    );
  }
}
