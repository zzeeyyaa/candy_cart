import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Jangan lupa import file ProductView yang baru kita buat
import 'features/product/product_view.dart'; 
import 'features/auth/auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables dari file .env
  await dotenv.load(fileName: ".env");

  // Inisiasi Supabase dengan URL dan Key dari .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tetap gunakan GetMaterialApp karena kita pakai GetX
    return GetMaterialApp(
      title: 'Candy Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      // Panggil AuthWrapper di sini untuk menangani login session
      home: const AuthWrapper(), 
    );
  }
}