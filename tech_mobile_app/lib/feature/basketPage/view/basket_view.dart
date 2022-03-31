import 'package:flutter/material.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Basket Page'),
      ),
      bottomNavigationBar: BottomNavbar(
        pageid: 2,
      ),
    );
  }
}
