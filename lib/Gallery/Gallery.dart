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
      print('result: $result');
      // Obtener la URL de cada imagen
      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        print('urls: $url');
        urls.add(url);
      }

      setState(() {
        imageUrls = urls;
      });
    } catch (e) {
      print("Error al obtener imágenes: $e");
    }
  }


  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image!;
    });
    upLoadImage();
  }

  Future<void> upLoadImage() async {
    try {
      setState(() {
        imageUrls = [];
      });
      Uint8List imageBytes = await _image.readAsBytes();
      String fileName = _image.name;

      // 3. Subir la imagen a Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putData(imageBytes);

      // 4. Obtener la URL de la imagen subida
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      fetchImages();
    } catch (e) {
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
        onPressed: getImage,
        child: const Icon(Icons.drive_folder_upload, color: Colors.white, size: 28),
      ),
    );
  }
}
