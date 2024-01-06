

import 'package:devjobs_updated/pages/employer/ChatsPage.dart';
import 'package:devjobs_updated/pages/employer/HomePage.dart';
import 'package:devjobs_updated/pages/employer/PaymentsPage.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with SingleTickerProviderStateMixin {
  int _index=0;
  List<Widget> _pages=
  [
    HomePage(),

    ChatsPage(),
    PaymentsPage()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: false,
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(icon: Icon(Icons.payments_rounded),label: 'Payments'),
        ],
      ),
    );
  }
}
