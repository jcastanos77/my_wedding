import 'dart:typed_data';

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
    double height = MediaQuery.sizeOf(context).height;
    Color colorPrincipal = Color(0xffd8d87c);

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
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      children: [
                        Text("Invitación", style: GoogleFonts.imperialScript(fontSize: 60, fontWeight: FontWeight.w500, color: colorPrincipal),),
                        SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            RotatedBox(
                              quarterTurns: -1,
                              child: Text("Jorge & Mayte", style: GoogleFonts.lexend(fontSize: 30, fontWeight: FontWeight.w300, color: colorPrincipal),),
                            ),
                            Expanded(child: Text("")),
                            QrImageView(
                              data: 'https://my-wedding-git-main-jcastanos77s-projects.vercel.app/',
                              version: QrVersions.auto,
                              size: 250.0,
                            ),
                            Expanded(child: Text("")),
                            RotatedBox(
                              quarterTurns: 1,
                              child: Text("Jorge & Mayte", style: GoogleFonts.lexend(fontSize: 30, fontWeight: FontWeight.w300, color: colorPrincipal),),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Column(
                          children: [
                            Text("Para: " + widget.namePerson, style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w300, color: colorPrincipal)),
                            Text("Personas: " + widget.numPersons, style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w300, color: colorPrincipal)),
                            Text("29/03/2025", style: GoogleFonts.lexend(fontSize: 20, fontWeight: FontWeight.w300, color: colorPrincipal)),
                          ],
                        )
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
                    Uint8List? list = byte?.buffer.asUint8List();
                    Share.shareXFiles([XFile.fromData(byte!, mimeType: "image/png")], text: "Invitación de " + widget.namePerson);
              }, child: Text("Compartir invitación", style: GoogleFonts.roboto(fontSize: 20, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
