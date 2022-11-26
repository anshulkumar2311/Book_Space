import 'package:book_space/HomeScreen.dart';
import 'package:book_space/constant.dart';
import 'package:book_space/pages/Donation.dart';
import 'package:book_space/pages/GetBook.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  int index=2;
  final screens = [
    HomeScreen(),
    Donation(),
    GetBook(),
  ];
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30,),
      Icon(Icons.currency_rupee,size: 30,),
      Icon(Icons.book,size: 30,)
    ];
    return  Scaffold(
      backgroundColor: mBackgroundColor,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white)
          ),
          child: CurvedNavigationBar(
            key: navigationKey,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.purple,
            color: Colors.blue,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(microseconds: 300),
            items: items,
            height: 60,
            index: index,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      );
  }
}
