import 'package:path/path.dart' as path;
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
  late XFile _image;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    setState(() {
      imageUrls = [];
    });
    List<String> urls = [];
    try {
      // Referencia a la carpeta "images" en Firebase Storage
      final ListResult result = await FirebaseStorage.instance.ref("images").listAll();
      // Obtener la URL de cada imagen
      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        urls.add(url);
      }

      setState(() {
        imageUrls = urls;
      });
    } catch (e) {
      print("Error al obtener imágenes: $e");
    }
  }

  Future<void> subirImagen() async {
    setState(() {
      imageUrls = [];
    });
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
        body: imageUrls.isEmpty
            ? Center(child: CircularProgressIndicator())
            :  GalleryImage(
          imageUrls: imageUrls,
          numOfShowImages: imageUrls.length,
          titleGallery: "Boda Jorge & Mayte",
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfff7bba9),
        onPressed: subirImagen,
        child: const Icon(Icons.drive_folder_upload, color: Colors.white, size: 28),
      ),
    );
  }
}
