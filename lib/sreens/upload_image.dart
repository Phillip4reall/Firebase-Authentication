// ignore_for_file: unused_local_variable, avoid_returning_null_for_void, use_build_context_synchronously, prefer_const_constructors, avoid_print, unused_element, sized_box_for_whitespace

import 'dart:io';

//import 'package:firebase_login/sreens/registration.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_storage_web/firebase_storage_web.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool loading = false;
// function to compress image
  Future<File> compressFile(File file) async {
    File compress =
        await FlutterNativeImage.compressImage(file.path, quality: 50);
    return compress;
  }

  // function to add image into database
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<void> uploadImage(String inputsource) async {
    final picker = ImagePicker();
    final XFile? pickImage = await picker.pickImage(
        source:
            inputsource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    if (pickImage == null) {
      return null;
    }
    String fileName = pickImage.name;
    File imageFile = File(pickImage.path);
    File compresss = await compressFile(imageFile);

    try {
      setState(() {
        loading = true;
      });
      await firebaseStorage.ref(fileName).putFile(compresss);
      setState(() {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image uploaded Successfully')));
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (error) {
      print(error);
    }
  }

  // function to display image from the database
  Future<List> displayImage() async {
    List<Map> files = [];
    final ListResult result = await firebaseStorage.ref().listAll();
    final List<Reference> allfiles = result.items;
    await Future.forEach(allfiles, (Reference file) async {
      final String fileurl = await file.getDownloadURL();
      files.add({'url': fileurl, 'path': file.fullPath});
    });
    print(files);
    return files;
  }

  // to delete image
  Future delete(String ref) async {
    await firebaseStorage.ref(ref).delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploading'),
        //centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const Icon(
            Icons.exit_to_app,
            size: 30,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: const [
                  Text(
                    'Upload Image',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                loading
                    ? Center(
                        child: const CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              uploadImage('camera');
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                uploadImage('gallery');
                              },
                              icon: const Icon(Icons.browse_gallery),
                              label: const Text('Gallery')),
                        ],
                      ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: displayImage(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.length ?? 0,
                            itemBuilder: (context, index) {
                              final Map image = snapshot.data[index];
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 200,
                                      child: Card(
                                          child: Image.network(image['url'])),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await delete(image['path']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Image deleted Successfully')));
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
