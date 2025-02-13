import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wedding/SplashWedding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAYd8--mfLCjQMSFwrIINp-mLNQZjwHpic",
        appId: "1:870428658400:web:bf43292a4aa4b094705e85",
        messagingSenderId: "870428658400",
        projectId: "my-wedding-402918"),
  );
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
      /*persistentFooterButtons: [
        kIsWeb ? FloatingActionButton(
          backgroundColor: Color(0xfff7bba9),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gallery()));
          },
          child: const Icon(Icons.photo, color: Colors.white, size: 28),
        ): FloatingActionButton(
          backgroundColor: Color(0xfff7bba9),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenerateImageInvitation()));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        )
      ],*/
    );
  }
}
