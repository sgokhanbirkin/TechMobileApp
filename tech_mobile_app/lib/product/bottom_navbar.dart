import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/feature/homePage/view/home_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key, required this.pageid}) : super(key: key);
  final int pageid;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.13,
      padding: EdgeInsets.only(top: context.height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item(
            icon: Icons.home,
            title: 'Home',
            pageName: "homePage",
            id: 0,
          ),
          item(
            icon: Icons.add,
            title: 'Add',
            pageName: "askQuestionPage",
            id: 1,
          ),
          item(
            icon: Icons.shopping_basket,
            title: 'Basket',
            pageName: "basketPage",
            id: 2,
          ),
          item(
            icon: Icons.person_add,
            title: 'Mines',
            pageName: "myQuestionsPage",
            id: 3,
          ),
          item(
            icon: Icons.person,
            title: 'Profile',
            pageName: "profilePage",
            id: 4,
          ),
        ],
      ),
    );
  }

  Widget item({
    required String title,
    required IconData? icon,
    required String pageName,
    required int id,
  }) {
    return InkWell(
      onTap: () {
        id != 0
            ? Navigator.pushNamedAndRemoveUntil(
                context, "/$pageName", (route) => false)
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ));
      },
      child: SizedBox(
        width: context.width * 0.2,
        child: Column(
          children: [
            Icon(
              icon,
              color: id == widget.pageid ? Colors.black : Colors.grey,
              size: context.height * 0.05,
            ),
            Text(
              title,
              style: TextStyle(
                color: id == widget.pageid ? Colors.black : Colors.grey,
                fontSize: context.height * 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
