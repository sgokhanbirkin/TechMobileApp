import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_mobile_app/core/providers/user_provider.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';
import 'package:tech_mobile_app/product/card_widget.dart';
import 'package:tech_mobile_app/product/comment_card.dart';
import 'package:tech_mobile_app/product/utils.dart';

class MyQuestionsView extends StatefulWidget {
  MyQuestionsView({Key? key}) : super(key: key);

  @override
  State<MyQuestionsView> createState() => _MyQuestionsViewState();
}

class _MyQuestionsViewState extends State<MyQuestionsView> {
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
      final user = FirebaseAuth.instance.currentUser!;
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
        title: Text('My Questions Page'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('questions')
            .where('userId', isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              var item = (snapshot.data! as dynamic).docs[index].data();
              return CardWidget(
                category: item['category'],
                description: item['description'],
                title: item['name'],
                url: item['postUrl'],
                value: item['value'],
                onPressed: () {},
                date: item['datePublished'],
              );
            },
            itemCount: (snapshot.data! as dynamic).docs.length,
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(
        pageid: 3,
      ),
    );
  }
}
