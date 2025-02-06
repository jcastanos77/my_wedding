import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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
                SizedBox(height: 24,),

              ],
            ),
          ),
        );
    }

  }
