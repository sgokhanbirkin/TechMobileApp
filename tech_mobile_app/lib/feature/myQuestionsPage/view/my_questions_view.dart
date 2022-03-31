import 'package:flutter/material.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';

class MyQuestionsView extends StatelessWidget {
  const MyQuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Questions Page'),
      ),
      body: Center(
        child: Text('My Questions Page'),
      ),
      bottomNavigationBar: BottomNavbar(
        pageid: 3,
      ),
    );
  }
}
