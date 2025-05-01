import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:myapp/Home/home_widget/home_widget.dart';
import 'package:myapp/profile/profile_page/profile_page.dart';
import 'package:myapp/profile/user_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  final List<Uint8List>? images;

  const MyHomePage({this.title, this.body, super.key, this.images});

  @override
  Widget build(BuildContext context) {
   final profileImage =  Provider.of<userModel>(context).user?.image;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: profileImage == null ? Icon(Icons.account_box) : CircleAvatar(child: ClipOval( child: Image.memory(profileImage, 
            fit: BoxFit.cover, height: 50, width: 50,),),)
          ),

          // IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
        ],
        title: Text("The  ${title ?? "Tree"}"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // First Image
            images == null || images!.isEmpty
                ? Image.asset("assets/download.jpeg")
                : Image.memory(
                  images![0],
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
            // Row with Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                FavWidgit(),
                // IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              ],
            ),
            // Text Description
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                body ?? "The vibe is so good",
              ),
            ),

            // Row for Seasons with image and text overlay
            images == null || images!.isEmpty
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MySeason(url: "assets/OIP.jpeg", text: "Fall"),
                    MySeason(url: "assets/bink.jpeg", text: "Spring"),
                  ],
                )
                : SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: images!.length,
                    itemBuilder:
                        (context, index) => Image.memory(
                          images![index],
                          height: 200,
                          width: 200,
                        ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
