import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_gallery/core/util/dependency_injection.dart';
import 'package:image_gallery/features/gallery_view/presentation/view/gallery_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: GalleryView(),
    );
  }
}
