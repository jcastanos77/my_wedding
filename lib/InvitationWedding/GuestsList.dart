import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Guestslist extends StatefulWidget {
  const Guestslist({Key? key}) : super(key: key);

  @override
  State<Guestslist> createState() => _GuestslistState();
}

class _GuestslistState extends State<Guestslist> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                    text: "Novia",
                    icon: Icon(Icons.girl),),
                Tab(
                    text: "Novio",
                    icon: Icon(Icons.boy)),
              ],
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.black,
            elevation: 1,
            title: Text("Lista de invitados", style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
          ),
          body: TabBarView(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('acompana', isEqualTo: 'novia')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (ctx, index){
                            return streamSnapshot.data!.docs.length == 0 ? Container(
                              color: Colors.black,
                              child: Center(
                                child: Text("Nadie quiere ir a tu boda aun"),
                              ),
                            ) : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () => _makePhoneCall(streamSnapshot.data!.docs[index]['number']),
                                    child: gradientCardSample(streamSnapshot.data!.docs[index]['full_name'],streamSnapshot.data!.docs[index]['asiste'],streamSnapshot.data!.docs[index]['number'])));
                          }
                      );
                    }),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('acompana', isEqualTo: 'novio')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (ctx, index){
                            return streamSnapshot.data!.docs.length == 0 ? Center(
                              child: Text("Nadie quiere ir a tu boda aun"),
                            ) : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () => _makePhoneCall(streamSnapshot.data!.docs[index]['number']),
                                    child: gradientCardSample(streamSnapshot.data!.docs[index]['full_name'],streamSnapshot.data!.docs[index]['asiste'],streamSnapshot.data!.docs[index]['number'])));
                          }
                      );
                    })
              ]),
        ),
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
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          color: Color(0xFFEAD2A8),
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
                  Text(name, style: GoogleFonts.openSans(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w600) ), // Adds a title to the card
                  Spacer(),
                  asiste == true ? Icon(Icons.check, color: Colors.green, size: 30) : Icon(Icons.close, color: Colors.red, size: 30)
                ],
              ),
              Text(number,style:GoogleFonts.openSans(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600), )
            ],
          ),
          Text(asiste == true ? "Asiste":"No Asiste", style: const TextStyle(
              fontSize: 20,
              color: Colors.black
          )) // Adds a price to the bottom of the card
        ],
      ),
    );
  }
}
