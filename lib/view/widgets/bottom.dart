import 'package:flutter/material.dart';
import 'package:money_flow/model/user/user.dart';
import 'package:money_flow/view/adviser.dart';
import 'package:money_flow/view/analysis.dart';
import 'package:money_flow/view/home_screen.dart';
import 'package:money_flow/view/profile.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _currentIndex = 0;
  User? currentUser;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    currentUser = User(name: "", age: "", phone: '', imagePath: "");

    _pages = [
      Homescreen(),
      analsys(),
      Advisor(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 235, 206, 120),
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        elevation: 7,
        onTap: (value) => {
          setState(() {
            _currentIndex = value;
          })
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pie_chart,
              color: Colors.black,
            ),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate,
              color: Colors.black,
            ),
            label: 'Advisor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
