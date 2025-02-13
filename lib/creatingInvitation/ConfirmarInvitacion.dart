import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ConfirmarInvitacion extends StatefulWidget {
  const ConfirmarInvitacion({Key? key}) : super(key: key);

  @override
  State<ConfirmarInvitacion> createState() => _ConfirmarInvitacionState();
}

class _ConfirmarInvitacionState extends State<ConfirmarInvitacion> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController nameInput = TextEditingController();
  TextEditingController telephoneInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String celNumber = "";
  String nombrePersona = "";
  bool selectedOption = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7bba9),
        elevation: 1,
        title: Text(
          "Confirma tu invitación",
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
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
                          textCapitalization: TextCapitalization.sentences,
                          decoration:
                              InputDecoration(labelText: "Nombre de invitado:"),
                          onChanged: (value) {
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
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: telephoneInput,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Número celular:"),
                          onChanged: (value) {
                            setState(() {
                              celNumber = value;
                            });
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
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
                ListTile(
                  title: const Text('Asistire'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No podre asistir'),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd8d87c)),
                      onPressed: () {
                        showAlertDialog(context);
                        var isLoadingFuture = Future.delayed(const Duration(seconds: 3), () {
                          return false;
                        });
                        isLoadingFuture.then((response) {
                          setState(() {
                            addUser();
                            Navigator.of(context).pop();
                          });
                        });

                      },
                      child: Text(
                        "Confirma tu presencia",
                        style: GoogleFonts.roboto(fontSize: 15, color: Colors.white),
                      )),
                ),
              ],
            ),
          )
    );
  }

  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Caragando..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<void> addUser() {
    return users
        .add({
      'full_name': nombrePersona,
      'number': celNumber,
      'asiste': selectedOption
    })
        .then((value) => Navigator.of(context).pop() )
        .catchError((error) => print("Failed to add user: $error"));
  }

}
