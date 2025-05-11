import 'package:flutter/material.dart';
import 'package:myapp/additem/AddItemScreen.dart';
import 'package:myapp/additem/item_model.dart';
import 'package:myapp/details/details_screen/details_page.dart';
import 'package:myapp/details/details_widget/fav.dart';
import 'package:myapp/profile/profile_page/profile_page.dart';
import 'package:myapp/profile/user_model.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImage = Provider.of<userModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: profileImage == null
                ? const Icon(Icons.account_box)
                : CircleAvatar(
                    child: ClipOval(
                      child: Image.memory(
                        profileImage,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: items.items.isEmpty
          ? const Center(child: Text("No items yet. Tap + to add one."))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.items.length,
              itemBuilder: (context, index) {
                final item = items.items[index];

                return InkWell(
                  onTap: () {
                    items.selectItem(item);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsPage(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        if (item.images.isNotEmpty)
                          Image.memory(
                            item.images.first,
                            height: 125,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        else
                          Container(
                            height: 125,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.image_not_supported),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FavWidgit(index: index), // ✅ This is the fix!
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const additem_screen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
