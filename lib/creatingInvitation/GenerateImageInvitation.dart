import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ImageInvitation.dart';

class GenerateImageInvitation extends StatefulWidget {
  const GenerateImageInvitation({Key? key}) : super(key: key);

  @override
  State<GenerateImageInvitation> createState() => _GenerateImageInvitationState();
}

class _GenerateImageInvitationState extends State<GenerateImageInvitation> {
  TextEditingController nameInput = TextEditingController();
  TextEditingController numPersonsInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String numPersonas = "";
  String nombrePersona = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xfff7bba9),
        elevation: 1,
        title: Text("Mi invitación", style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: nameInput,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          labelText: "Nombre de invitado:"
                      ),
                    onChanged: (value){
                      setState(() {
                        nombrePersona = value;
                      });
                    },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: numPersonsInput,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Número de personas:"
                      ),
                      onChanged: (value){
                        setState(() {
                          numPersonas = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),

                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xffd8d87c)),
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "Crear invitación",
                    desc: "¿Estas seguro de crear la invitación?",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Crear",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageInvitation(namePerson: nombrePersona,numPersons: numPersonas,)));
                          nameInput.clear();
                          numPersonsInput.clear();
                        },
                        width: 120,
                        color: Colors.black87,
                      ),
                      DialogButton(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                        color: Colors.red,
                      )
                    ],
                  ).show();
                },
                child: Text("Crea tu invitación", style: GoogleFonts.roboto(fontSize: 15, color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }
}
