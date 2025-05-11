import 'package:flutter/material.dart';
import 'package:myapp/additem/item_model.dart';
import 'package:myapp/dashboard/nav_bar.dart';
import 'package:myapp/favourite/favourite_model.dart';
import 'package:myapp/profile/user_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        
        
        
        
        ChangeNotifierProvider(create: (context) => userModel())
        , ChangeNotifierProvider(create: (context) => ItemModel())
                , ChangeNotifierProvider(create: (context) => FavoriteModel())]

     , child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Web Demo',
      theme: ThemeData(useMaterial3: true),
      home: NavBar(),
    );
  }
}
