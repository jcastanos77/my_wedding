import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wedding/InvitationWedding/CreateInvitation.dart';
import 'package:my_wedding/checkListWedding/CheckListPage.dart';

import 'InvitationWedding/Invitation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'My Wedding'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    CheckListPage(),
    CreateInvitation(),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xffFFFFFF),
      ),*/
      body: SafeArea(
        child: Invitation(),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff000000),
        selectedItemColor:  Color(0xffF9AA33),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Check List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_invitation_outlined),
            label: 'Invitación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: 'Game',
          ),
        ],
      ),*/
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
