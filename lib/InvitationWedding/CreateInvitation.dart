import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_wedding/InvitationWedding/Invitation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:map_location_picker/map_location_picker.dart';

class CreateInvitation extends StatefulWidget {
  const CreateInvitation({Key? key}) : super(key: key);

  @override
  State<CreateInvitation> createState() => _CreateInvitationState();
}

class _CreateInvitationState extends State<CreateInvitation> {

  TextEditingController dateInput = TextEditingController();
  TextEditingController nombreNoviosInput = TextEditingController();
  TextEditingController lugarBodaInput = TextEditingController();
  TextEditingController lugarIglesiaInput = TextEditingController();
  TextEditingController nombrePadrinoInput = TextEditingController();
  TextEditingController nombreMadrinaInput = TextEditingController();
  TextEditingController fraseDeNoviosInput = TextEditingController();

  String autocompletePlace = "null";
  String nombreNovios = "";
  String nombrePadrino = "";
  String nombreMadrina = "";
  String fechaBoda = "";
  String lugarBoda = "";
  String lugarIglesia = "";
  String fraseDeNovios = "";
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DateFormat dateFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMEEEEd('es_MX');
  }

  void _refresh() {
    setState(() {});
  }

  @override
    Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('invitation');

    Future<void> createInvitation() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'nombreNovios': nombreNovios,
        'nombrePadrino': nombrePadrino,
        'nombreMadrina': nombreMadrina,
        'fechaBoda': fechaBoda,
        'lugarBoda': lugarBoda,
        'lugarIglesia': lugarIglesia,
        'fraseDeNovios': fraseDeNovios
      })
          .then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Invitation())))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return  Scaffold(
          backgroundColor: Colors.white10,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18,),
                Text("Crea tu invitacion llenando este formulario", style: TextStyle(color: Colors.black),),
                SizedBox(height: 18,),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nombreNoviosInput,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: "Boda de:"
                        ),
                        onChanged: (value){
                         nombreNovios = value;
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
                        controller: dateInput,
                        readOnly: true,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            labelText: "Fecha de boda:"
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2050),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.dark(),
                                  child: child!,
                                );
                              });

                          if (pickedDate != null) {

                            String formattedDate =
                            dateFormat.format(pickedDate);

                            setState(() {
                              dateInput.text =
                                  formattedDate;
                              fechaBoda = formattedDate;
                            });
                          } else {}
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8,),
                      PlacesAutocomplete(
                        left: false,
                        right: false,
                        bottom: false,
                        region: 'MX',
                        topCardColor: Colors.white,
                        topCardShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        showClearButton: false,
                        top: false,
                        topCardMargin:  EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        decoration: InputDecoration(
                            labelText: "Lugar de boda:"
                        ),
                        searchController: lugarBodaInput,
                        apiKey: 'AIzaSyAYd8--mfLCjQMSFwrIINp-mLNQZjwHpic',
                        mounted: mounted,
                        hideBackButton: true,
                        onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
                          if (result != null) {
                            setState(() {
                              autocompletePlace = result.result.formattedAddress ?? "";
                            });
                          }
                        },
                      ),
                      SizedBox(height: 8,),
                      PlacesAutocomplete(
                        left: false,
                        right: false,
                        bottom: false,
                        region: 'MX',
                        topCardColor: Colors.white,
                        topCardShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        showClearButton: false,
                        top: false,
                        topCardMargin:  EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        decoration: InputDecoration(
                            labelText: "Lugar de iglesia:"
                        ),
                        searchController: lugarIglesiaInput,
                        apiKey: 'AIzaSyAYd8--mfLCjQMSFwrIINp-mLNQZjwHpic',
                        mounted: mounted,
                        hideBackButton: true,
                        onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
                          if (result != null) {
                            setState(() {
                              autocompletePlace = result.result.formattedAddress ?? "";
                            });
                          }
                        },
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Nombres papas novia:"
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Nombres papas novio:"
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: nombreMadrinaInput,
                        decoration: InputDecoration(
                            labelText: "Nombre madrina:"
                        ),
                        onChanged: (value){
                          nombreMadrina = value;
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
                        controller: nombrePadrinoInput,
                        decoration: InputDecoration(
                            labelText: "Nombre padrino:"
                        ),
                          onChanged: (value){
                            nombreMadrina = value;
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
                        controller: fraseDeNoviosInput,
                        decoration: InputDecoration(
                            labelText: "Frase de novios:"
                        ),
                        onChanged: (value){
                          fraseDeNovios = value;
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
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Crear invitación",
                        desc: "¿Estas seguro de crear la invitación?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            color: Colors.red,
                          ),
                          DialogButton(
                            child: Text(
                              "Crear",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => createInvitation(),
                            width: 120,
                            color: Colors.black87,
                          )
                        ],
                      ).show();
                    },
                    child: Text("Crea tu nueva aventura", style: GoogleFonts.roboto(fontSize: 15),)
                ),
                SizedBox(height: 24,),

              ],
            ),
          ),
        );
    }

  }
