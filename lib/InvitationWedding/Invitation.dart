import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class Invitation extends StatefulWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Boda", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Mayte y Jorge", style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 30),),
                  Text("20 de octubre del 2024", style: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ],),
              ),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  opacity: 0.9,
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
                  Text("Nuestros padres", style: GoogleFonts.homemadeApple(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 120,
                    child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16),
                        scrollDirection: Axis.vertical,
                        childAspectRatio: (1 / .25),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        children: [
                          Text("Carmen Alicia Mayorquin", textAlign: TextAlign.left,style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                          Text("Maria Teresa Castro", textAlign: TextAlign.left, style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                          Text("Jorge Alberto Castaños", textAlign: TextAlign.left, style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                          Text("Juan Cota", textAlign: TextAlign.left, style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500))
                        ]),
                  ),
                  SizedBox(height: 24,),
                  Text("Nuestros padrinos", style: GoogleFonts.homemadeApple(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Text("Padrino Prueba Uno", textAlign: TextAlign.left,style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 8,),
                  Text("Madrina Prueba Dos", textAlign: TextAlign.left, style: GoogleFonts.raleway(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
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
                    child: Text("Jardin Duland, MARIA TERESA DE CALCUTA, Los Misioneros, Ciudad Obregón, Sonora, Mexico",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 24,),
                  Icon(Icons.church),
                  Text("Ceremonia Religiosa:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Parroquia de Nuestra Señora de Guadalupe, Ciudad Obregón, Sonora, Mexico",
                      textAlign: TextAlign.center,style: GoogleFonts.dancingScript(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
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
                  Text("El mejor tipo de amor es el que despierta el alma y nos hace aspirar a más", textAlign: TextAlign.center,style: GoogleFonts.homemadeApple(color: Colors.white, fontSize: 20),),
                  Text("-Mayte y Jorge", style: GoogleFonts.raleway(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ],),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  opacity: 0.9,
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
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Container(),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  opacity: 0.9,
                  image: AssetImage('assets/secondImage.jpg'),
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
                  Text("Dias restantes:", style: GoogleFonts.raleway(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 24,),
                  Container(
                    height: 100,
                    color: Colors.indigo,
                    child: Center(
                      child: TimerCountdown(
                        timeTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        descriptionTextStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        format: CountDownTimerFormat.daysHoursMinutesSeconds,
                        hoursDescription: "Horas",
                        daysDescription: "Dias",
                        minutesDescription: "Minutos",
                        secondsDescription: "Segundos",
                        endTime: DateTime.now().add(
                          Duration(
                            days: 5,
                            hours: 14,
                            minutes: 27,
                            seconds: 34,),
                       ),
                      onEnd: () {
                       print("Timer finished");
                      },
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}