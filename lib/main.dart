import 'package:flutter/material.dart';
import 'package:safe_choice/produc_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Supabase.initialize(
  //   url: 'https://nwdncjhdgkksvollpgsw.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53ZG5jamhkZ2trc3ZvbGxwZ3N3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyMTUzMTMsImV4cCI6MjA1OTc5MTMxM30.7CGPTFjI7WwxoN2Xmr-imIhobpqs9yaJX1JGwi9uGfI',
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Choice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductScreen(),
    );
  }
}

