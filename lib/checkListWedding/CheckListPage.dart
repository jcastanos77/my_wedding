import 'package:flutter/material.dart';
import 'package:my_wedding/checkListWedding/typeCheckList.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text("CheckList básico",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 5.0),
              Text("para tu boda",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                margin:  EdgeInsets.all(10.0),
                height: 0.5,
                color: Colors.black,
              ),
              TypeCheckList(title: "Escenciales",data: ["Fecha de la boda", "Definir presupuesto", "Lista de invitados"
                , "Apartar lugar de ceremonia y recepción"],),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Ceremonia", data: ["Trámites","Objetos simbólicos","Decoración","Anillos","Damas de honor",
                "Padrinos"]),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Recepción",data: ["Centros de mesa", "Banquete y bebidas","Decoración","Libro de firmas",
                "Postre y/o pastel", "Aperitivos"]),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Definir",data: ["Invitaciones", "Transporte de novios", "Mesa de regalos","Souvenirs",
                "Despedida de soltera","Proyectos DIY","Asignación de lugares","Agradecimientos para papás y damas",
                "Luna de miel"]),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Proveedores",data: ["Catering","Fotografia y video","Flores","Música: ceremonia y recepción"]),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Look de la novia",data: ["Vestido","Ramo","Maquillaje","Accesorios","Kit de emergencia","Peinado"]),
              SizedBox(height: 5.0),
              TypeCheckList(title: "Look del novio",data: ["Traje","Boutonniere","Accesorios","Arreglo personal:corte de cabello, etc."]),

            ],
          ),
        ),
      ),
    );
  }
}
