
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ImageInvitation extends StatefulWidget {
  const ImageInvitation({required this.namePerson, required this.numPersons});

  final String namePerson;
  final String numPersons;

  @override
  State<ImageInvitation> createState() => _ImageInvitationState();
}

class _ImageInvitationState extends State<ImageInvitation> {
  WidgetsToImageController controller = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    Color colorPrincipal = Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7bba9),
        elevation: 1,
        title: Text("Comparte tu invitación", style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
      body: Center(
        child: Column(
          children: [
            WidgetsToImage(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 16,),
                        Image.asset("assets/iconJm.png", height: 55, width: 160, fit: BoxFit.fill, filterQuality: FilterQuality.high,),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            RotatedBox(
                              quarterTurns: -1,
                              child: Text("Mayte & Jorge", style: GoogleFonts.alice(fontSize: 30, fontWeight: FontWeight.w300, color: colorPrincipal, letterSpacing: 1.5),),
                            ),
                            Expanded(child: Text("")),
                            QrImageView(
                              data: 'https://myweddingjm.fyi/',
                              version: QrVersions.auto,
                              size: 250.0,
                            ),
                            Expanded(child: Text("")),
                            RotatedBox(
                              quarterTurns: 1,
                              child: Text("Mayte & Jorge", style: GoogleFonts.alice(fontSize: 30, fontWeight: FontWeight.w300, color: colorPrincipal, letterSpacing: 1.5),),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Column(
                          children: [
                            Text("PARA: " + widget.namePerson.toUpperCase(), style: GoogleFonts.alice(fontSize: 16, fontWeight: FontWeight.w300, color: colorPrincipal)),
                            Text("NÚMERO DE PERSONAS: " + widget.numPersons, style: GoogleFonts.alice(fontSize: 16, fontWeight: FontWeight.w300, color: colorPrincipal)),
                            SizedBox(height: 16,),
                            Text("29 DE MARZO DEL 2025", style: GoogleFonts.alice(fontSize: 16, fontWeight: FontWeight.w300, color: colorPrincipal)),
                          ],
                        ),
                        SizedBox(height: 16,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: width - 16,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: colorPrincipal),
                  onPressed: () async{
                    final byte = await controller.capture();
                    Share.shareXFiles([XFile.fromData(byte!, mimeType: "image/png")], text: "Invitación de " + widget.namePerson);
              }, child: Text("Compartir invitación", style: GoogleFonts.roboto(fontSize: 20, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
