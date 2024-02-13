import 'package:flutter/material.dart';
import 'package:myproject/src/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FirstApp",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.loginpage,
      // onGenerateRoute: AppRoute.generateRoute,
      
      routes: AppRoute.all,
    );
    
  }
}