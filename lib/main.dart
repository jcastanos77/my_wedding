import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wedding/Gallery/Gallery.dart';
import 'package:my_wedding/InvitationWedding/Invitation.dart';
import 'package:my_wedding/SplashWedding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_wedding/creatingInvitation/ConfirmarInvitacion.dart';
import 'InvitationWedding/GuestsList.dart';
import 'creatingInvitation/GenerateImageInvitation.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MyHomePage(title: 'My Wedding')),
    GoRoute(path: '/galeria', builder: (context, state) => const Gallery()),
    GoRoute(path: '/invitacion', builder: (context, state) => const Invitation()),
    GoRoute(path: '/confirmarInvitacion', builder: (context, state) => const ConfirmarInvitacion()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerConfig: _router,
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
  final GlobalKey<AnimatedFloatingActionButtonState> key =GlobalKey<AnimatedFloatingActionButtonState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: Splashwedding(),
      ), floatingActionButton: kIsWeb ? Container() : AnimatedFloatingActionButton(
      //Fab list
        fabButtons: <Widget>[
       FloatingActionButton(
             onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Guestslist()));
             },
         heroTag: '1',
             child: Icon(Icons.list_alt_outlined),
        ),
          FloatingActionButton(
            backgroundColor: Color(0xfff7bba9),
            heroTag: '2',
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenerateImageInvitation()));
            },
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          )
        ],
        key : key,
        colorStartAnimation: Color(0xfff7bba9),
        colorEndAnimation: Color(0xfff7bba9),
        animatedIconData: AnimatedIcons.menu_close,
    ),
    );
  }
}
