

import 'package:devjobs_updated/pages/admin/AdminHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminNavPage extends StatefulWidget {

  const AdminNavPage({super.key});

  @override
  State<AdminNavPage> createState() => _AdminNavPageState();
}

class _AdminNavPageState extends State<AdminNavPage> with SingleTickerProviderStateMixin {
  User? user=FirebaseAuth.instance.currentUser;
  int _index=0;
  List<Widget> _pages=[
    AdminHome(


    ),




  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              _index=index;
            });

          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded),label: 'Dashboard'),

            BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chat'),

          ],
        ),
      ),
    body: _pages[_index],
    );
  }
}
