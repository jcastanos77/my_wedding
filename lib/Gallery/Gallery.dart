import 'dart:io';
import 'dart:html' as html show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> imageUrls = [];
  late Future<List<String>> futureImages;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    futureImages = fetchImages();
  }

  Future<List<String>> fetchImages() async {
    List<String> urls = [];
    try {
      final storageRef = FirebaseStorage.instance.ref().child("images");
      final ListResult result = await storageRef.listAll();

      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        urls.add("$url&s=500");
      }
    } catch (e) {
      debugPrint("❌ Error al obtener imágenes: $e");
    }
    return urls;
  }

  Future<void> subirImagen() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    if (images == null || images.isEmpty) {
      debugPrint("⚠ No se seleccionaron imágenes.");
      return;
    }

    setState(() {
      isUploading = true;
    });
    showLoadingDialog();

    try {
      List<Future<String>> uploadTasks = [];

      for (XFile image in images) {
        final Reference storageRef = FirebaseStorage.instance.ref().child(
            'images/${DateTime.now().millisecondsSinceEpoch}_${image.name}');

        File file = File(image.path);
        UploadTask uploadTask = storageRef.putFile(file);

        uploadTasks.add(uploadTask.then((snapshot) => snapshot.ref.getDownloadURL()));
      }

      List<String> downloadUrls = await Future.wait(uploadTasks);

      setState(() {
        futureImages = fetchImages(); // 🔄 Recargar la galería
        isUploading = false;
      });

      // 🔹 Cerrar el diálogo de carga
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint("❌ Error al subir imágenes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7bba9),
        elevation: 1,
        title: Text("Galeria", style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
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

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Subiendo imágenes..."),
            ],
          ),
        );
      },
    );
  }
}
