import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:my_wedding/creatingInvitation/ConfirmarInvitacion.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../Gallery/Gallery.dart';

class Invitation extends StatefulWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  bool isWeddingDay = false;
  static const List<String> sampleImages = [
    "assets/2.jpeg","assets/3.jpeg","assets/4.jpeg","assets/9.JPG","assets/8.JPG",
  ];

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString(), enableJavaScript: true, forceSafariVC: true);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime a = DateTime(2025,3,29,07,00);
    DateTime b = DateTime.now();
    Duration difference = a.difference(b);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    DateTime dt1 = DateTime.now();
    DateTime dt2 = DateTime.parse("2025-03-29");

    if (sonFechasIguales(dt1,dt2)){
      setState(() {
        isWeddingDay = true;
      });
    }else{
      setState(() {
        isWeddingDay = false;
      });
    }

    return Scaffold(
      floatingActionButton: isWeddingDay ? FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => context.go('/galeria'),
        child: const Icon(Icons.photo, color: Colors.white, size: 28),
        heroTag: '3',
      ) : FloatingActionButton(
        heroTag: '2',
        backgroundColor: Colors.black,
        child: Icon(Icons.insert_invitation, color: Colors.white, size: 28),
        onPressed: () => context.go('/confirmarInvitacion'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Boda", style: GoogleFonts.raleway(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  Text("Jorge y Mayte", style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 35),),
                  SizedBox(height: 24,),
                  Text("29 de marzo del 2025", style: GoogleFonts.raleway(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.punch_clock_rounded,color: Colors.white),
                        Text("Dias restantes:", style: GoogleFonts.raleway(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Flexible(
                          child: Container(
                            color: Colors.black.withOpacity(.1),
                            height: 100,
                            child: Center(
                              child: TimerCountdown(
                                timeTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                descriptionTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                colonsTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                                hoursDescription: "Horas",
                                daysDescription: "Dias",
                                minutesDescription: "Minutos",
                                secondsDescription: "Segundos",
                                endTime: DateTime.now().add(
                                  Duration(
                                    days: 0,
                                    hours: 0,
                                    minutes: 0,
                                    seconds: 0,),
                                ),
                                onEnd: () {
                                  print("Timer finished");
                                  setState(() {
                                    isWeddingDay = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(1),
                image: const DecorationImage(
                  image: AssetImage('assets/principaImage.jpeg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.black12, width: 1),
              ),
            ),
            SizedBox(height: 24,),
            Container(
              child: Column(
                children: [
                  Icon(Icons.family_restroom),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Padres novia", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text("Ma. Teresa Castro Avila", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800)),
                          SizedBox(height: 8,),
                          Text("Juan Angel Cota", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      SizedBox(width: 24,),
                      Column(
                        children: [
                          Text("Padres Novio", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text("Carmen Mayorquin", textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Jorge Castaños", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Text("Nuestros padrinos", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Marycela Gaxiola", textAlign: TextAlign.left,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Pedro González", textAlign: TextAlign.left, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      SizedBox(width: 24,),
                      Column(
                        children: [
                          Text("Lorena Flores", textAlign: TextAlign.left,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Julio Maldonado", textAlign: TextAlign.left, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800)),
                        ],
                      )
                    ],
                  ),
                 ],
              ),
            ),
            SizedBox(height: 24,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Icon(Icons.church),
                  Text("Ceremonia Religiosa:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("Parroquia de Nuestra Señora de Guadalupe",
                    textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("Hora: 4:00 P.M.",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  MaterialButton(
                    elevation: 1,
                    color: Color(0xfff7bba9),
                    onPressed: () => {
                      navigateTo(27.490368, -109.938906)
                    },
                    child: Text('Mostrar en el mapa', style: GoogleFonts.lato(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(height: 24,),
                  Icon(Icons.location_on),
                  Text("Evento Social:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("La Roca",
                    textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("Ceremonia Civil",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Hora: 8:00 P.M.",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("Evento",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Hora: 9:00 P.M.",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  MaterialButton(
                    elevation: 1,
                    color: Color(0xfff7bba9),
                    onPressed: () => {
                      navigateTo(27.553944, -109.926336)
                    },
                    child: Text('Mostrar en el mapa', style: GoogleFonts.lato(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24,),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("El amor se construye todos los dias.", textAlign: TextAlign.center,style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 25),),
                  SizedBox(height: 16,),
                  Text("Jorge & Mayte", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ],),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(1),
                image: const DecorationImage(
                  image: AssetImage('assets/thirdImage.jpeg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.black12, width: 1),
              ),
            ),
            SizedBox(height: 24,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Icon(FontAwesomeIcons.shirt),
                  Text("Codigo de vestimenta:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Formal con tenis",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset("assets/gift.png", height: 18, width: 18),
                  Text("Sugerencia de regalo:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                  Text("¡Tu asistencia es lo mas importante!", style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Text("Pero si deseas darnos un regalo, agradecemos sea en efectivo.",textAlign: TextAlign.center ,style: GoogleFonts.raleway(color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal),),
                  SizedBox(height: 24,),
                ],
              ),
            ),
            Container(
              color: Color(0xffd8d87c),
              child: Column(
                children: [
                  SizedBox(height: 24,),
                  Icon(Icons.monochrome_photos, color: Colors.white,),
                  Text("Nuestros momentos:", style: GoogleFonts.raleway(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  FanCarouselImageSlider(
                    imagesLink: sampleImages,
                    isAssets: true,
                    indicatorActiveColor: Colors.white,
                    autoPlay: false,
                    imageFitMode: BoxFit.cover,
                    isClickable: false,
                  ),
                  SizedBox(height: 24,),
                ],
              ),
            ),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }

  bool sonFechasIguales(DateTime a, DateTime b) {
    if (a.year == b.year && a.month == b.month && a.day == b.day) {return true;}
    else if (a.year >= b.year && a.month >= b.month && a.day >= b.day){ return  true;}
    else {return false;}
  }

}