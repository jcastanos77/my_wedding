import 'dart:io';
import 'dart:html' as html show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> imageUrls = [];
  late Future<List<String>> futureImages;
  bool isUploading = false;

  Uint8List reducirCalidadWeb(Uint8List imageBytes) {
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) return imageBytes;

    Uint8List compressedBytes = Uint8List.fromList(img.encodeJpg(image, quality: 70));
    return compressedBytes;
  }

  @override
  void initState() {
    super.initState();
    futureImages = fetchImages();
  }

  Future<List<String>> fetchImages() async {
    List<String> urls = [];
    setState(() {
      imageUrls = [];
    });
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

    try {
      Uint8List? imageBytes;

      if (kIsWeb) {
        // 📌 Usa ImagePickerWeb para seleccionar imágenes en Web (Safari compatible)
        //imageBytes = await ImagePickerWeb.getImageAsBytes();
      } else {
        final picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          imageBytes = await image.readAsBytes();
        }
      }
      setState(() {
        isUploading = true;
      });

      if (imageBytes == null) {
        print("⚠ No se seleccionó ninguna imagen.");
        return;
      }

      // 📌 Subir a Firebase Storage
      final Reference storageRef = FirebaseStorage.instance.ref().child(
          'images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageRef.putData(imageBytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("✅ Imagen subida: $downloadUrl");

      setState(() {
        futureImages = fetchImages();
        isUploading = false;
      });

    } catch (e) {
      setState(() {
        isUploading = false; // Desactivamos la carga en caso de error
      });
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
        body: isUploading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Subiendo imágenes..."),
            ],
          ),
        ) : FutureBuilder<List<String>>(
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
        onPressed: () => subirImagen(),
        child: const Icon(Icons.drive_folder_upload, color: Colors.white, size: 28),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final int numOfShowImages;
  final List<String> imageUrls;

  const GalleryImage({
    Key? key,
    required this.numOfShowImages,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: numOfShowImages,
      itemBuilder: (context, index) {
        return Image.network(imageUrls[index], fit: BoxFit.cover);
      },
    );
  }
}
