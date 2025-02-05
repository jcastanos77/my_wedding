import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wedding/InvitationWedding/CreateInvitation.dart';
import 'package:my_wedding/InvitationWedding/Invitation.dart';
import 'package:my_wedding/SplashWedding.dart';
import 'package:my_wedding/checkListWedding/CheckListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_wedding/creatingInvitation/ImageInvitation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyAYd8--mfLCjQMSFwrIINp-mLNQZjwHpic",
      appId: "1:870428658400:web:bf43292a4aa4b094705e85",
      messagingSenderId: "870428658400",
      projectId: "my-wedding-402918"));
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Mi boda',
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
      body: SafeArea(
        child: Splashwedding(),
      ),
      /*ImageInvitation(namePerson: "Castaños Samaniego", numPersons: "2")*/
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
}
