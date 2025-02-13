import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Guestslist extends StatefulWidget {
  const Guestslist({Key? key}) : super(key: key);

  @override
  State<Guestslist> createState() => _GuestslistState();
}

class _GuestslistState extends State<Guestslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7bba9),
        elevation: 1,
        title: Text("Lista de invitados", style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
      body: StreamBuilder(
    stream: FirebaseFirestore.instance
    .collection('users')
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    return ListView.builder(
    itemCount: streamSnapshot.data!.docs.length,
    itemBuilder: (ctx, index){
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
            onTap: () => _makePhoneCall(streamSnapshot.data!.docs[index]['number']),
            child: gradientCardSample(streamSnapshot.data!.docs[index]['full_name'],streamSnapshot.data!.docs[index]['asiste'],streamSnapshot.data!.docs[index]['number'])));
    }
    );
    }),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget gradientCardSample(String name, bool asiste, String number) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ Color(0xFF846AFF), Color(0xFF755EE8), Colors.purpleAccent,],
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600) ), // Adds a title to the card
                  Spacer(),
                  asiste == true ? Icon(Icons.check, color: Colors.green, size: 30) : Icon(Icons.close, color: Colors.red, size: 30)
                ],
              ),
              Text(number,style:GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600), )
            ],
          ),
          Text(asiste == true ? "Asiste":"No Asiste", style: const TextStyle(
              fontSize: 24,
              color: Colors.white
          )) // Adds a price to the bottom of the card
        ],
      ),
    );
  }
}
