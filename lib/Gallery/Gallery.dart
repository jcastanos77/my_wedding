import 'dart:io';
import 'dart:html' as html show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

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

  Future<void> subirImagen(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: kIsWeb, // ✅ Necesario para Web
      );

      if (result == null || result.files.isEmpty) {
        debugPrint("⚠ No se seleccionaron imágenes.");
        Navigator.of(context).pop(); // 🔄 Cerrar el diálogo si el usuario cancela
        return;
      }

      showLoadingDialog(context);

      List<Future<String>> uploadTasks = [];

      for (var file in result.files) {
        final Reference storageRef = FirebaseStorage.instance.ref().child(
            'images/${DateTime.now().millisecondsSinceEpoch}_${file.name}');

        UploadTask uploadTask;
        if (kIsWeb) {
          uploadTask = storageRef.putData(file.bytes!);
        } else {
          uploadTask = storageRef.putFile(File(file.path!));
        }

        uploadTasks.add(uploadTask.then((snapshot) => snapshot.ref.getDownloadURL()));
      }

      // 🔹 Esperar todas las subidas
      List<String> downloadUrls = await Future.wait(uploadTasks);
      debugPrint("✅ Imágenes subidas: $downloadUrls");

      // 🔄 Cerrar el diálogo cuando termine la subida
      Navigator.of(context).pop();

      setState(() {
        futureImages = fetchImages(); // 🔄 Recargar la galería
      });

    } catch (e) {
      debugPrint("❌ Error al subir imágenes: $e");
      Navigator.of(context).pop(); // 🔄 Cerrar el diálogo en caso de error
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
        onPressed: () => subirImagen(context),
        child: const Icon(Icons.drive_folder_upload, color: Colors.white, size: 28),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // No permitir que el usuario lo cierre manualmente
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // Evitar cierre con botón atrás
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Subiendo imágenes..."),
              ],
            ),
          ),
        );
      },
    );
  }
}
