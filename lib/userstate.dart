
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/pages/admin/AdminNavPage.dart';
import 'package:devjobs_updated/pages/employer/HomePage.dart';
import 'package:devjobs_updated/pages/freelancer/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'common/login/LoginPage.dart';

class UserState extends StatefulWidget {
  @override
  _UserStateState createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      String userType = await _getUserType(user);
      if (userType == "Freelancer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FHomePage()),
        );
      } else if(userType=='Employer'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }else if(userType=="Admin")
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminNavPage(),
          ),
        );
      }else
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
    }
  }

  Future<String> _getUserType(User user) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .get();

    if (documentSnapshot.exists) {
      return documentSnapshot.get('usertype') ?? "";
    } else {
      throw 'Document does not exist in the database';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
