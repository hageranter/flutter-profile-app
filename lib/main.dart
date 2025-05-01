import 'package:flutter/material.dart';
import 'package:myapp/FirstScreen.dart';
import 'package:myapp/profile/user_model.dart';
import 'package:provider/provider.dart';

 

void main() {
  runApp( 
    
    ChangeNotifierProvider(create: (context)=> userModel()
    ,child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Web Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  Firstscreen(),
    );
  }
}
