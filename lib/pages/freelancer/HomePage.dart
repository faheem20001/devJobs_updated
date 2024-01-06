



import 'package:devjobs_updated/common/profile/ProfilePage.dart';
import 'package:devjobs_updated/models/freelancer/user_model.dart';
import 'package:devjobs_updated/pages/freelancer/AlertPage.dart';
import 'package:devjobs_updated/pages/freelancer/ChatPage.dart';
import 'package:devjobs_updated/pages/freelancer/ContractPage.dart';
import 'package:devjobs_updated/pages/freelancer/Home.dart';
import 'package:devjobs_updated/services/common/logoutservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FHomePage extends StatefulWidget {
  final UserModel? data;
  const FHomePage({super.key, this.data});

  @override
  State<FHomePage> createState() => _FHomePageState();
}

class _FHomePageState extends State<FHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[
    Home(),
    ContractPage(),
    ChatPage(),
    AlertPage()
  ];

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Jobs"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Contracts"),
            BottomNavigationBarItem(
                icon: Icon(Icons.messenger), label: "Chats"),
            BottomNavigationBarItem(
                icon: Icon(Icons.celebration), label: "Alerts"),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "DevJobs",
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w900),
        ),
        actions: [
          InkWell(
        onTap: (){
          logout out=logout();
          out.log_out(context);
        },
            child: Icon(
              Icons.logout,
              size: 40,
              color: Colors.black,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
              return ProfilePage(uid: user!.uid,);
            }));
          },
          child: Container(
            width: 200,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                    left: 20,
                    top: 25,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                      size: 40,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
