import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:myapp/additem/item.dart';
import 'package:myapp/dashboard/dashboard_screen.dart';
import 'package:myapp/additem/item_model.dart';
import 'package:provider/provider.dart';

class additem_screen extends StatefulWidget {
  const additem_screen({super.key});

  @override
  State<additem_screen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<additem_screen> {
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
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/download.jpeg"),
          ),
        ),
        child: Consumer<ItemModel>(
          builder:
              (context, itemModel, child) => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 60,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    itemModel.selectedImages.isEmpty
                        ? Container(
                          color: Colors.white38,
                          height: 150,
                          width: MediaQuery.sizeOf(context).width - 20,
                          child: IconButton(
                            onPressed: itemModel.imageSelector,
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
                                onPressed: itemModel.imageSelector,
                                icon: const Icon(Icons.camera_alt),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width - 120,
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children:
                                    itemModel.selectedImages
                                        .map(
                                          (toElement) => Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
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
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                  ),
                                                  onPressed: () {
                                                    itemModel.removeImage(
                                                      toElement,
                                                    );
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: title,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          final itemModel = Provider.of<ItemModel>(context, listen: false);

          if (title.text.isEmpty ||
              body.text.isEmpty ||
              itemModel.selectedImages.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all fields and select images."),
              ),
            );
            return;
          }

          final newItem = Item(
            title: title.text,
            body: body.text,
            images: List<Uint8List>.from(itemModel.selectedImages),
            favourite: false,
          );

          itemModel.addItem(newItem);
          itemModel.selectedImages.clear();
          title.clear();
          body.clear();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        },
      ),
    );
  }
}
