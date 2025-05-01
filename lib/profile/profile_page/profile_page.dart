import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/profile/profile_wodget/options.dart';
import 'package:myapp/profile/user_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Consumer<userModel>(
              builder: (context, userModel, child) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 100,
                          child: userModel.user?.image == null
                              ? const Icon(Icons.person, size: 100, color: Colors.white)
                              : ClipOval(
                                  child: Image.memory(
                                    userModel.user!.image!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Profile",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Options(
                                            title: "Camera",
                                            icon: Icons.camera_alt,
                                            color: Colors.green,
                                            onPressesd: () {
                                              userModel.imageSelector(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Options(
                                            title: "Gallery",
                                            icon: Icons.image,
                                            color: Colors.green,
                                            onPressesd: () {
                                              userModel.imageSelector(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          Options(
                                            title: "Delete",
                                            icon: Icons.delete,
                                            color: Colors.red,
                                            onPressesd: () {
                                              userModel.removeImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.camera_alt, size: 25),
                          ),
                        ),
                      ],
                    ),

                    // 👇 NEW: name and bio displayed even without image
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Name"),
                      subtitle: Text(userModel.user?.name ?? "Hager"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text("Bio"),
                      subtitle: Text(userModel.user?.bio ?? " Work Coding"),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
