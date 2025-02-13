import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_wedding/InvitationWedding/Invitation.dart';
import 'package:animated_background_view/animated_background_view.dart';

class Splashwedding extends StatefulWidget {
  const Splashwedding({Key? key}) : super(key: key);

  @override
  State<Splashwedding> createState() => _SplashweddingState();
}

class _SplashweddingState extends State<Splashwedding> {

  @override
  Widget build(BuildContext context) {
    final colorPrincipal = Color(0xff76453c);
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        color: Colors.white.withOpacity(0.4),
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            AnimatedBackground(
              colors: [
                Color(0xfff7bba9),
                Color(0xffd8d87c)
              ],
              fps: 60,
              type: BackgroundType.movingGlares,
              blur: false,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 350,
                  height: 350,
                  color: Colors.black.withOpacity(0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Eres especial para nosotros", style: GoogleFonts.lato(color: colorPrincipal, fontSize: 25, fontWeight: FontWeight.w300),),
                      SizedBox(height: 8,),
                      Text("Jorge", style: GoogleFonts.windSong(color: colorPrincipal, fontSize: 40, fontWeight: FontWeight.w600),),
                      Text("     Mayte", textAlign: TextAlign.center, style: GoogleFonts.windSong(color: colorPrincipal, fontSize: 40, fontWeight: FontWeight.w600)),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Marzo", textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorPrincipal, fontSize: 20, fontWeight: FontWeight.w300)),
                          SizedBox(width: 32,),
                          Text("29", textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorPrincipal, fontSize: 40, fontWeight: FontWeight.w300)),
                          SizedBox(width: 32,),
                          Text("2025", textAlign: TextAlign.center, style: GoogleFonts.lato(color: colorPrincipal, fontSize: 20, fontWeight: FontWeight.w300)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      FloatingActionButton.extended(
                        backgroundColor: Color(0xfff7bba9),
                        heroTag: '213',
                        onPressed: (){ setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Invitation()),
                          );
                        }); },
                        label: const Text('Vamos a tu invitación', style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}