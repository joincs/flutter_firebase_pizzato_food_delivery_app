import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizza_delivery_app/Services/maps.dart';
import 'package:pizza_delivery_app/providers/authentication.dart';
import 'package:pizza_delivery_app/providers/calculations.dart';
import 'package:pizza_delivery_app/providers/payment.dart';
import 'package:provider/provider.dart';
import './Views/splash_screen.dart';
import './Helpers/headers.dart';
import './Helpers/middle.dart';
import './Services/manageData.dart';
import './Helpers/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Headers(),
        ),
        ChangeNotifierProvider.value(
          value: MiddleHelpers(),
        ),
        ChangeNotifierProvider.value(
          value: ManageData(),
        ),
        ChangeNotifierProvider.value(
          value: Footers(),
        ),
        ChangeNotifierProvider.value(
          value: GenerateMaps(),
        ),
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
        ChangeNotifierProvider.value(
          value: Calculations(),
        ),
        ChangeNotifierProvider.value(
          value: PaymentHelper(),
        ),
      ],
      child: MaterialApp(
        title: 'Pizzato',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.red,
          primaryColor: Colors.redAccent,
          fontFamily: 'Roboto-Regular',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
