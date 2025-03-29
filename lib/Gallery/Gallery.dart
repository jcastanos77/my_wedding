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

  Future<void> upLoadImage() async {

    try {
      setState(() {
        imageUrls = [];
      });
      File file = File(_image.path);
      String nameWithoutExtension = path.basenameWithoutExtension(_image.name);
      String fileName = nameWithoutExtension + "${DateTime.now().millisecondsSinceEpoch}.png";
      print("------------");
      print(fileName);
      // 3. Subir la imagen a Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
      // Subir archivo
      UploadTask uploadTask = ref.putFile(file);

      // Esperar a que termine la subida
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("✅ Imagen subida con éxito: $downloadUrl");
      fetchImages();
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }

  Future<void> subirImagen() async {
    setState(() {
      imageUrls = [];
    });
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes == null) {
        print("No se seleccionó ninguna imagen.");
        return;
      }

      UploadTask uploadTask = storageRef.putData(imageBytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("✅ Imagen subida en Web: $downloadUrl");
      fetchImages();
    }
    catch (e) {
      print('Error al subir la imagen: $e');
    }
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
