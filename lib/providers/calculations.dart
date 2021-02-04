import 'package:flutter/material.dart';
import 'package:pizza_delivery_app/Services/manageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cheeseValue = 0, becanValue = 0, onionValue = 0, cartData = 0;
  String size;
  String get getSize => size;
  bool isSelected = false,
      smallTapped = false,
      mediumTapped = false,
      largeTapped = false,
      seleted = false;
  int get getCheeseValue => cheeseValue;
  int get getbecanValue => becanValue;
  int get getOnionValue => onionValue;
  int get getcartData => cartData;
  bool get getSelected => getSelected;

  addCheese() {
    cheeseValue++;
    notifyListeners();
  }

  addBeacon() {
    becanValue++;
    notifyListeners();
  }

  addOnion() {
    onionValue++;
    notifyListeners();
  }

  minusOnion() {
    onionValue--;
    notifyListeners();
  }

  minusBecan() {
    becanValue--;
    notifyListeners();
  }

  minusCheese() {
    cheeseValue--;
    notifyListeners();
  }

  selectSmallSize() {
    smallTapped = true;
    size = 'S';
    notifyListeners();
  }

  selectMediumSize() {
    mediumTapped = true;
    size = 'M';
    notifyListeners();
  }

  selectLargeSize() {
    largeTapped = true;
    size = 'L';
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    becanValue = 0;
    onionValue = 0;
    mediumTapped = false;
    smallTapped = false;
    largeTapped = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<ManageData>(context, listen: false)
          .submitData(context, data);
      notifyListeners();
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 50.0,
            child: Center(
              child: Text(
                "Select Size",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
