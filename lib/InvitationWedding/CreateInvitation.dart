import 'package:flutter/material.dart';
import 'package:my_wedding/InvitationWedding/Invitation.dart';

class CreateInvitation extends StatefulWidget {
  const CreateInvitation({Key? key}) : super(key: key);

  @override
  State<CreateInvitation> createState() => _CreateInvitationState();
}

class _CreateInvitationState extends State<CreateInvitation> {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 18,),
              Text("Crea tu invitacion llenando este formulario", style: TextStyle(color: Colors.black),),
              SizedBox(height: 18,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Invitation()));
                  },
                  child: Text("Crea tu invitación")
              )

            ],
          ),
        ),
      );
    }
  }
