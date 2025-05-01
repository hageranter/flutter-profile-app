import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Home/home_screen/home_page.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<Uint8List> selectedImages = [];

  Future<void> imageSelector() async {
    final List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null && mounted) {
      final bytesList = await Future.wait(
        images.map((file) => file.readAsBytes()),
      );
      setState(() {
        selectedImages.addAll(bytesList);
      });
    }
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/download.jpeg"),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
          child: Column(
            children: [
              const SizedBox(height: 30),
              selectedImages.isEmpty
                  ? Container(
                      color: Colors.white38,
                      height: 150,
                      width: MediaQuery.sizeOf(context).width - 20,
                      child: IconButton(
                        onPressed: imageSelector,
                        icon: const Icon(Icons.camera_alt),
                      ),
                    )
                  : Row(
                      children: [
                        Container(
                          color: Colors.white38,
                          height: 150,
                          width: 100,
                          child: IconButton(
                            onPressed: imageSelector,
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width - 120,
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: selectedImages
                                .map(
                                  (toElement) => Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Image.memory(
                                          toElement,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              selectedImages.remove(toElement);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
              TextField(
                controller: title,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter title",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: body,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Enter body",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                title: title.text,
                body: body.text,
                images: selectedImages,
              ),
            ),
          );
        },
      ),
    );
  }
}
