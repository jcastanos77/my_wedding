import 'dart:io';
import 'dart:html' as html show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> imageUrls = [];
  late Future<List<String>> futureImages;

  @override
  void initState() {
    super.initState();
    futureImages = fetchImages();
  }

  Future<List<String>> fetchImages() async {
    setState(() {
      imageUrls = [];
    });
    List<String> urls = [];
    try {
      final storageRef = FirebaseStorage.instance.ref().child("images");

    final ListResult result = await storageRef.listAll();
      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        url += "&s=500";
        urls.add(url);
      }

      setState(() {
        imageUrls = urls;
      });
    } catch (e) {
      debugPrint("Error al obtener imágenes: $e");
    }
      return urls;
  }

  Future<void> subirImagen() async {

    final Reference storageRef = FirebaseStorage.instance.ref().child(
        'images/${DateTime
            .now()
            .millisecondsSinceEpoch}.jpg');
    if (kIsWeb) {
      try {
        Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
        if (imageBytes == null) {
          print("No se seleccionó ninguna imagen.");
          return;
        }

        UploadTask uploadTask = storageRef.putData(imageBytes);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        print("✅ Imagen subida en Web: $downloadUrl");

      }
      catch (e) {
        print('Error al subir la imagen: $e');
      }
    }else{
      try {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(
            source: ImageSource.gallery);
        if (image == null) {
          print("No se seleccionó ninguna imagen.");
          return;
        }
        setState(() {
          imageUrls = [];
        });
        File file = File(image.path);
        UploadTask uploadTask = storageRef.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        print("✅ Imagen subida en Android/iOS: $downloadUrl");
      }catch(e){
        print('Error al subir la imagen: $e');
      }
    }
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7bba9),
        elevation: 1,
        title: Text("Galleria", style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
      ),
        body:FutureBuilder<List<String>>(
          future: futureImages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error al cargar imágenes"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No hay imágenes disponibles"));
            }

            return Center(
              child: GalleryImage(
                numOfShowImages: snapshot.data!.length,
                imageUrls: snapshot.data!,
              ),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfff7bba9),
        onPressed: subirImagen,
        child: const Icon(Icons.drive_folder_upload, color: Colors.white, size: 28),
      ),
    );
  }
}
