import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/core/constant/services/firestore_methods.dart';
import 'package:tech_mobile_app/feature/loginPage/service/login_service.dart';
import 'package:tech_mobile_app/feature/loginPage/view/login_view.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';
import 'package:tech_mobile_app/product/follow_button.dart';
import 'package:tech_mobile_app/product/utils.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var userData = {};
  int postLength = 0;
  bool isFollowing = false;
  bool isLoading = false;
  String uid = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await FirebaseAuth.instance.currentUser!;
      uid = user.uid;
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      bottomNavigationBar: BottomNavbar(
        pageid: 4,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      userData["photoUrl"] ??
                          "https://cdn.iconscout.com/icon/free/png-256/avatar-371-456323.png",
                    ),
                    radius: 40,
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                _customCard(userData['name'] ?? '', true),
                SizedBox(height: context.height * 0.02),
                _customCard('Edit Profile', false),
                SizedBox(height: context.height * 0.01),
                _customCard('Settings', false),
                SizedBox(height: context.height * 0.01),
                _customCard('My Products', false),
                SizedBox(height: context.height * 0.01),
                _customCard('Stats', false),
                SizedBox(height: context.height * 0.01),
                Container(
                  height: context.height * 0.15,
                  width: context.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Balance',
                            style: TextStyle(
                              fontSize: context.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '0.00 TMC',
                            style: TextStyle(
                              fontSize: context.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.pink.shade200,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Add Balance',
                            style: TextStyle(
                              fontSize: context.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          FollowButton(
            text: 'Sign Out',
            backgroundColor: Colors.pink.shade200,
            textColor: Colors.white,
            borderColor: Colors.grey,
            function: () async {
              await LoginService().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          ),
        ],
      ),
    );
  }

  Container _customCard(String text, bool isName) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isName ? Colors.pink.shade400 : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.pink,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isName ? FontWeight.bold : FontWeight.normal,
            color: isName ? Colors.white : Colors.pink,
          ),
        ),
      ),
    );
  }
}
