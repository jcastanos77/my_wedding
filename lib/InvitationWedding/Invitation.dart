import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class Invitation extends StatefulWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('invitation').snapshots();

  static const List<String> sampleImages = [
    "assets/principaImage.jpg","assets/secondImage.jpg","assets/thirdImage.jpg","assets/thirdImage.jpg"
  ];

  String nombreNovios = "";
  String nombrePadrino = "";
  String nombreMadrina = "";
  String fechaBoda = "";
  String lugarBoda = "";
  String lugarIglesia = "";
  String fraseDeNovios = "";

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  openMapsSheet(context, double lat, double lng) async {
      final coords = Coords(lat, lng);
      final title = "Bodorrio mayte y jorgais";
      final availableMaps = await MapLauncher.installedMaps;

      await availableMaps.first.showMarker(
        coords: Coords(lat, lng),
        title: title,
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('invitation')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          nombreNovios = doc["nombreNovios"];
          fechaBoda = doc["fechaBoda"];
          nombrePadrino = doc["nombrePadrino"];
          nombreMadrina = doc["nombreMadrina"];
          lugarBoda = doc["lugarBoda"];
          lugarIglesia = doc["lugarIglesia"];
          fraseDeNovios = doc["fraseDeNovios"];
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    DateTime a = DateTime(2025,3,29,16,00);
    DateTime b = DateTime.now();
    Duration difference = a.difference(b);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Boda", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Jorge y Mayte", style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 30),),
                  Text("29 de marzo del 2025", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.punch_clock_rounded,color: Colors.white),
                        Text("Dias restantes:", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Container(
                          color: Colors.black.withOpacity(.1),
                          height: 100,
                          child: Center(
                            child: TimerCountdown(
                              timeTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              descriptionTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              colonsTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              format: CountDownTimerFormat.daysHoursMinutesSeconds,
                              hoursDescription: "Horas",
                              daysDescription: "Dias",
                              minutesDescription: "Minutos",
                              secondsDescription: "Segundos",
                              endTime: DateTime.now().add(
                                Duration(
                                  days: days,
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds,),
                              ),
                              onEnd: () {
                                print("Timer finished");
                              },
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
                  image: AssetImage('assets/principaImage.jpg'),
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
                          Text("Padres novia", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text("Maria Castro Avila", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
                          SizedBox(height: 8,),
                          Text("Juan Angel Cota", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      SizedBox(width: 24,),
                      Column(
                        children: [
                          Text("Padres Novio", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          Text("Carmen Mayorquin", textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Jorge Castaños", textAlign: TextAlign.center, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  Text("Nuestros padrinos", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Lorena Flores", textAlign: TextAlign.left,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Julio Maldonado", textAlign: TextAlign.left, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      SizedBox(width: 24,),
                      Column(
                        children: [
                          Text("Marycela Gaxiola", textAlign: TextAlign.left,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),),
                          SizedBox(height: 8,),
                          Text("Pedro González", textAlign: TextAlign.left, style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
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
                  Icon(Icons.location_on),
                  Text("Ubicación del evento:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("La Roca",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
              MaterialButton(
                elevation: 1,
                color: Color(0xfff7bba9),
                onPressed: () => {
                  openMapsSheet(context,27.553944, -109.926336)
                },
                child: Text('Mostrar en el mapa', style: GoogleFonts.lato(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),),
                  ),
                  SizedBox(height: 24,),
                  Icon(Icons.church),
                  Text("Ceremonia Religiosa:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Parroquia de Nuestra Señora de Guadalupe",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  MaterialButton(
                    elevation: 1,
                    color: Color(0xfff7bba9),
                    onPressed: () => {
                      openMapsSheet(context,27.490368, -109.938906)
                    },
                    child: Text('Mostrar en el mapa', style: GoogleFonts.lato(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
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
                  Text(fraseDeNovios, textAlign: TextAlign.center,style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 20),),
                  Text("-${nombreNovios}", style: GoogleFonts.raleway(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ],),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(1),
                image: const DecorationImage(
                  image: AssetImage('assets/thirdImage.jpg'),
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
                  Icon(Icons.science_rounded),
                  Text("Codigo de vestimenta:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Formal",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Text("Respetuosamente no niños",
                    textAlign: TextAlign.center,style: GoogleFonts.raleway(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            SizedBox(height: 24,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset("assets/gift.png", height: 18, width: 18),
                  Text("Sugerencia de regalo:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Text("¡Tu asistencia es lo mas importante!", style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Text("Pero si deseas darnos un regalo, agradecemos sea en efectivo.",textAlign: TextAlign.center ,style: GoogleFonts.raleway(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
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
                  Text("Nuestros momentos:", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  FanCarouselImageSlider(
                    imagesLink: sampleImages,
                    isAssets: true,
                    indicatorActiveColor: Colors.white,
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
}
