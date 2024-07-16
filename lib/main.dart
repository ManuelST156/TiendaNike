import 'package:flutter/material.dart';
import 'package:nike_store/models/cart_model.dart';
import 'package:nike_store/pages/intro_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://naoflenqutshacihgmmv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hb2ZsZW5xdXRzaGFjaWhnbW12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA2OTk3MjQsImV4cCI6MjAzNjI3NTcyNH0.foI0KXYF8RPr8msWWHQe6tMovTL7hxE_gsA2PDdkJ64',
  );

  runApp(
    ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: IntroPage(),
    );
  }
}
